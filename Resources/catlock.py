#!/usr/bin/env python3
"""Tested by Cat

re-write of catlock, using PyQt5

Screen lock program using assets generated by //badabing// DailyBing.app
 
retain name catlock? Balthazar is still Test Kitty #1. 
I can't use it myself if it can't protect from my cat!


"""
import os 
import pwd
import sys
import time
import getopt
import datetime
import threading
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit
from PyQt5.QtGui import QPixmap, QFont
from PyQt5.QtCore import Qt, QTimer, QDateTime
from PyQt5.QtDBus import QDBusConnection, QDBusInterface, QDBusReply

HOME = os.getenv('HOME')
LOCAL = os.path.dirname(os.path.abspath(__file__))

"""
RepeatedTimer

Run every 10 minutes check if a new wallpaper has been downloaded
"""
class RepeatedTimer(object):
  def __init__(self, interval, function, *args, **kwargs):
    self._timer = None
    self.interval = interval
    self.function = function
    self.args = args
    self.kwargs = kwargs
    self.is_running = False
    self.next_call = time.time()
    self.start()

  def _run(self):
    self.is_running = False
    self.start()
    self.function(*self.args, **self.kwargs)

  def start(self):
    if not self.is_running:
      self.next_call += self.interval
      self._timer = threading.Timer(self.next_call - time.time(), self._run)
      self._timer.start()
      self.is_running = True

  def stop(self):
    self._timer.cancel()
    self.is_running = False


class CatLock(QWidget):

    def __init__(self, dbus, valid, sysname, pin, fontFamily, tz, width, height):
        """
        CatLock application
        """
        # Create widget
        super().__init__()  

        print(f'Resolution width: {width}, height: {height} ')
        if height >=1280:
            self.factor = 2
        else:  
            self.factor = 1.5
        self.lockedFlag = True
        self.counter = 0
        self.eol = 0
        self.rollover = False

        self.setWindowFlags(    # M a g i c k !
                              Qt.WindowStaysOnTopHint       # cover eveything else
                            | Qt.FramelessWindowHint        # no border
                            | Qt.X11BypassWindowManagerHint # displays on top of panels
                            | Qt.Popup                      # recapture keyboard input fom menu
                            )

        self.activateWindow()
        self.raise_()
        self.grabKeyboard()
        self.grabMouse()
        self.left = 0
        self.top = 0
        self.width = width
        self.height = height
        self.dbus = dbus
        self.valid = valid
        self.sysname = sysname
        self.count = 0
        self.pin = pin
        self.fontFamily = fontFamily
        print("font = "+self.fontFamily)
        self.tz = tz
        self.fullName = pwd.getpwuid(os.getuid()).pw_gecos
        self.fullName = self.fullName.replace(",,,", "")
        if self.fullName == "":
            self.fullName = pwd.getpwuid(os.getuid()).pw_name


        with open(LOCAL + '/themes/wallpaper.description') as f:
            self.title = f.readline()
            tmp = f.readline()
            self.info = tmp.split("(©")[0]
            self.copyright = "(©" + tmp.split("(©")[1] + ")"

        self.authorize = QPixmap(LOCAL + '/themes/wallpaper.authorize.jpg').scaled(width, height)
        self.locked = QPixmap(LOCAL + '/themes/wallpaper.locked.jpg').scaled(width, height)

        self.setGeometry(self.left, self.top, self.width, self.height)

        if os.path.exists(f'/{HOME}/.iface'):
            self.avatar = QPixmap(f'{HOME}/.iface')
        else:
            self.avatar = QPixmap(LOCAL + '/avatar.png')
    
        clockFont = QFont(self.fontFamily, int(60*self.factor), QFont.Normal)
        calendarFont = QFont(self.fontFamily, int(32*self.factor), QFont.Normal)
        titleFont = QFont(self.fontFamily, int(16*self.factor), QFont.Normal)
        infoFont = QFont(self.fontFamily, int(12*self.factor), QFont.Normal)
        copyrightFont = QFont(self.fontFamily, 18, QFont.Normal)

        textFont = QFont(self.fontFamily, 30, QFont.Normal)
        nameFont = QFont(self.fontFamily, 20, QFont.Normal)
        instructionFont = QFont(self.fontFamily, 10, QFont.Normal)

        self.background = QLabel(self)
        self.background.setPixmap(self.locked)

        self.userpic = QLabel(self)
        self.userpic.setPixmap(self.avatar)
        self.userpic.move(int(self.width*.5 - self.userpic.width()*.5), int(self.height*.35))
        self.userpic.setVisible(False)

        self.username = QLabel(self)
        self.username.setFont(nameFont)
        self.username.setText(self.fullName)
        self.username.move(int((self.width*.5)-(len(self.fullName)*.5)-(len(self.fullName)*6)), int(self.height*.666-80))
        self.username.setStyleSheet("color: white")
        self.username.setVisible(False)

        self.textbox = QLineEdit(self)
        self.textbox.setEchoMode(QLineEdit.Password)
        self.textbox.setFont(textFont)
        
        x = int((self.width*.5)-125)
        y = int(self.height*.666)

        self.textbox.move(x, y)
        self.textbox.resize(280, 50)
        self.textbox.setVisible(False)
        self.textbox.setAlignment(Qt.AlignCenter)

        radius = 10
        self.textbox.setStyleSheet(
            """
            color:rgba(54, 69, 79, 255);
            background:rgba(250, 244, 211, 127);
            border-top-left-radius:{0}px;
            border-bottom-left-radius:{0}px;
            border-top-right-radius:{0}px;
            border-bottom-right-radius:{0}px;
            """.format(radius)
        )

        self.instructions = QLabel(self)
        self.instructions.setFont(instructionFont)
        self.instructions.setText("Enter PIN")
        self.instructions.move(int(self.width*.5)-30, int(self.height*.666+60))
        self.instructions.setVisible(False)
        self.instructions.setStyleSheet("color: white;" )

        self.titlebox = QLabel(self)
        self.titlebox.setFont(titleFont)
        self.titlebox.setText(self.title)
        self.titlebox.move(60, 40)
        self.titlebox.setStyleSheet("color: white;")
        self.titlebox.setFocusPolicy(Qt.ClickFocus | Qt.TabFocus | Qt.NoFocus)


        self.infobox = QLabel(self)
        self.infobox.setFont(infoFont)
        self.infobox.setText(self.info)
        self.infobox.move(60, 95)
        self.infobox.setStyleSheet("color: white;")

        self.copybox = QLabel(self)
        self.copybox.setFont(copyrightFont)
        self.copybox.setText(self.copyright[:-1])
        self.copybox.move(60, 140)
        self.copybox.setStyleSheet("color: white;")

        self.clock = QLabel(self)
        self.clock.setFont(clockFont)
        # self.clock.move(60, int(self.height * 0.70))
        self.clock.move(60, int(self.height * 0.65))
        self.clock.setStyleSheet("color: white;")
        self.calendar = QLabel(self)        
        self.calendar.setFont(calendarFont)
        self.calendar.move(60, int(self.height * 0.85))
        self.calendar.setStyleSheet("color: white;")

        self.showTime()
        self.clock.show()
        self.calendar.show()

        timer = QTimer(self)
        timer.timeout.connect(self.showTime)
        timer.start(1000) # update every second
        self.show()

        self.rt = RepeatedTimer(60, checkDownloadStatus, self, valid, dbus) 
        
    def eventFilter(self, source, event):
        print(source)
        print(event)
        return super(CatLock, self).eventFilter(source, event)

    def showTime(self):
        current_date = datetime.date.today()

        t = datetime.time()

        if self.rollover == True:
            print("Rollover?")
            # same time that download runs+10

        currentTime = QDateTime.currentDateTime()
        adj = 60*60*(self.tz)   # because I'm stuck in Eastern Time Zone (helloSystem)

        currentTime = currentTime.addSecs(adj)

        self.clock.setText(currentTime.toString('h:mm a      '))
        self.calendar.setText(currentTime.toString('dddd,  MMMM d      '))

        # check if we're ready to return to lock screen
        if self.lockedFlag == False:
            self.counter += 1
            if self.counter > 10: #30:
                self.lockedFlag = True
                self.background.setPixmap(self.locked)
                self.textbox.setText("")
                self.textbox.setVisible(False)
                self.username.setVisible(False)
                self.userpic.setVisible(False)
                self.instructions.setVisible(False)

                self.titlebox.setVisible(True)
                self.infobox.setVisible(True)
                self.copybox.setVisible(True)
                self.clock.setVisible(True)
                self.calendar.setVisible(True)  

    def keyPressEvent(self, event):
        """
        decode the keypress:

            Key_Escape
                kills input, relock screen

            Key_Return
                force check of valid pin
                clear input buffer

            Key_Backspace
                delete last char

        """
        if event.key() == Qt.Key_Escape:
            # self.exitLock()

            self.background.setPixmap(self.locked)
            self.textbox.setText("")
            self.textbox.setVisible(False)
            self.username.setVisible(False)
            self.userpic.setVisible(False)
            self.instructions.setVisible(False)

            self.titlebox.setVisible(True)
            self.infobox.setVisible(True)
            self.copybox.setVisible(True)
            self.clock.setVisible(True)
            self.calendar.setVisible(True)  

        elif event.key() == Qt.Key_Return:
            if self.textbox.text() == self.pin:
                self.exitLock()
            self.textbox.clear()

        elif event.key() == Qt.Key_Backspace:
            if self.textbox.hasFocus():
                self.textbox.backspace()
            else:
                self.textbox.setText(self.textbox.text()[:-1])

        else:
            self.lockedFlag = False
            self.counter = 0 # reset timer to go back to lock screen

            if self.textbox.isHidden():
                self.titlebox.setVisible(False)
                self.infobox.setVisible(False)
                self.copybox.setVisible(False)
                self.clock.setVisible(False)
                self.calendar.setVisible(False)
                  
                self.background.setPixmap(self.authorize)
                self.username.setVisible(True)
                self.textbox.setVisible(True)
                self.userpic.setVisible(True)
                self.instructions.setVisible(True)
                self.textbox.setText(event.text())

            else:
                if self.textbox.hasFocus():
                    if self.textbox.text() == self.pin:
                        self.exitLock()
                else:
                    self.textbox.setText(self.textbox.text()+event.text())
                    self.textbox.repaint()
                    if self.textbox.text() == self.pin:
                        QTimer.singleShot(250, lambda:self.exitLock())  

    def exitLock(self):
        """
        exit screen lock
        """
        self.rt.stop() 

        self.releaseKeyboard()
        self.releaseMouse()
        self.close()
        exit()

    def reset(self):
        self.counter = 0
        self.lockedFlag = True
        self.background.setPixmap(self.locked)
        self.textbox.setText("")
        self.textbox.setVisible(False)
        self.username.setVisible(False)
        self.userpic.setVisible(False)
        self.instructions.setVisible(False)

        self.titlebox.setVisible(True)
        self.infobox.setVisible(True)
        self.copybox.setVisible(True)
        self.clock.setVisible(True)
        self.calendar.setVisible(True)  



def checkDownloadStatus(self, valid, dbus):
    if valid:
        print("checkDownloadStatus: dbus.isValid()?")
        if dbus.isValid():
            print("dbus is valid")
            msg = dbus.call('downloaded', sys.argv[1] if len(sys.argv) > 1 else "")
            reply = QDBusReply(msg)

            if reply.isValid():
                if reply.value() == True:
                    print("checkDownloadStatus: dbus returned True")
                    # load new screen image
                    with open(LOCAL + '/themes/wallpaper.description') as f:
                        self.title = f.readline()
                        tmp = f.readline()
                        self.info = tmp.split("(")[0]
                        self.copyright = tmp.split("(")[1]

                    self.authorize = QPixmap(LOCAL + '/themes/wallpaper.authorize.jpg')
                    self.locked = QPixmap(LOCAL + '/themes/wallpaper.locked.jpg')
                    self.reset()

                    # restart program & exit
                    # subprocess.Popen(["python3", f'{LOCAL}/catlock.py'])   
                    # self.exitLock()
                else:
                    print("checkDownloadStatus: dbus returned False")
            else:
                print("checkDownloadStatus: reply not valid")


if __name__ == '__main__':
    #
    # bail if already running:
    #
    # Simple singleton:
    # Ensure that only one instance of this application is running by trying to kill the other ones
    # p = QProcess()
    # p.setProgram("pkill")
    # p.setArguments(["-f", os.path.abspath(__file__)])
    # cmd = p.program() + " " + " ".join(p.arguments())
    # print(cmd)
    # p.start()
    # p.waitForFinished()



    usage = """Usage:
catlock [OPTION?]

Help Options:
-h, --help           Show help options

Application Options:
--pin                lock number
--font               font family
--tz                 time zone correction
"""

    pin = '1234'
    fontFamily = 'Verdana'
    tz = 0
    dbus = None
    valid = False

    app = QApplication(sys.argv)


    try:
        if not QDBusConnection.sessionBus().isConnected():
            print("Cannot connect to the D-Bus session bus.\n"
                    "To start it, run:\n"
                    "\teval `dbus-launch --auto-syntax`\n");
        else:
            print("Connected to dbus")
            dbus = QDBusInterface('com.darkoverlordofdata.wallpaper.downloaded', '/', '',
                    QDBusConnection.sessionBus())
            print("DBus is valid?")
            print(dbus.isValid())
            if dbus.isValid():
                valid = True
    finally:
        pass

    screen = app.primaryScreen()
    size = screen.size()
    width = size.width()
    height = size.height()

    try:
        opts, args = getopt.getopt(sys.argv[1:], 
                                        "hp:f:t:w:h", 
                                        [ 
                                            "help",
                                            "pin=",
                                            "font=",
                                            "tz=" 
                                        ])
    except getopt.GetoptError:  
        print(usage)
        sys.exit(2)

    for opt, arg in opts:
        if opt in ["-h", "--help"]:
            print(usage)
            sys.exit()
        elif opt in ["-p", "--pin"]:
            pin = arg
        elif opt in ["-f", "--font"]:
            fontFamily = arg
        elif opt in ["-t", "--tz"]:
            tz = int(arg)

    print("starting...")

    ex = CatLock(dbus, valid, os.uname().sysname, pin, fontFamily, tz, width, height)
    app.exec_()
    sys.exit()


