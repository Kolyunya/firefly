//  Led parameters
unsigned char ledPin[3] = { 6 , 3 , 5 };
unsigned char ledColor[3] = { 0 , 0 , 0 };
unsigned char ledBrightness = 100;
bool ledState = true;
bool autoMode = true;

//  Client command
String command;

//  Processes input commands received over the Bluetooth connection
void processInputCommands ( void )
{

    //  While there is some data on the serial port
    while ( Serial.available() )
    {

        //  Read one character from the serial port
        int character = Serial.read();

        //  Full command received
        if ( character == '\n' )
        {

            //  Client requested to switch the LED on
            if ( command == "ON" )
            {
                ledState = true;
                updateLedColor();
            }

            //  Client requested to switch the LED off
            else if ( command == "OFF" )
            {
                ledState = false;
                updateLedColor();
            }

            //  Client requested to alter the LED brightness
            else if ( command.startsWith("BRIGHTNESS:") )
            {
                command.replace("BRIGHTNESS:","");
                ledBrightness = command.toInt();
                updateLedColor();
            }

            //  Client requested to alter the LED color
            else if ( command.startsWith("COLOR:") )
            {
                command.replace("COLOR:","");
                ledColor[0] = ( "0x" + command.substring(0,1) ).toInt();
                ledColor[1] = ( "0x" + command.substring(2,3) ).toInt();
                ledColor[2] = ( "0x" + command.substring(4,5) ).toInt();
                updateLedColor();
            }

            //  Client requested to enable auto mode
            else if ( command == "AUTO" )
            {
               autoMode = true;
            }

            //  Command was processed or ignored
            command = "";

        }

        //  The command was not received completely yes
        else
        {

          //  Add the character to the command
          command += (char)character;

        }

    }

}

//  Performs automatic LED color transition
void performColorTransition ( void )
{

    //  Current alteration direction of each LED
    static bool ledDirection[3] =
    {
        random(0,2),
        random(0,2),
        random(0,2)
    };

    for ( unsigned char ledId = 0 ; ledId < 4 ; ledId++ )
    {

        //  When alternation reached the end-point...
        if
        (
            (
                ledColor[ledId] == 0
                    &&
                ledDirection[ledId] == false
            )
                ||
            (
                ledColor[ledId] == 255
                    &&
                ledDirection[ledId] == true
            )
        )
        {

            //  Try to switch the alternation direction
            if ( ! random(0,42) )
            {
                ledDirection[ledId] =! ledDirection[ledId];
            }

        }

        //  Alternation end-point is not reached yet
        else
        {

            //  Alter LED color
            ledColor[ledId] += ledDirection[ledId] ? 1 : -1;

        }

    }

    Serial.print(ledColor[0]);
    Serial.print('\t');
    Serial.print(ledColor[1]);
    Serial.print('\t');
    Serial.print(ledColor[2]);
    Serial.print('\n');

    //  Update LED color
    updateLedColor();

    //  Apply some delay
    delay(142);

}

//  Updates the PWM signal on led pins to match requested color and brightness
void updateLedColor ( void )
{

    //  The LED is switched on
    if ( ledState == true )
    {

        //  Write color values corrected by the brightness coefficient to the LED pins
        analogWrite(ledPin[0],ledColor[0]*ledBrightness/100);
        analogWrite(ledPin[1],ledColor[1]*ledBrightness/100);
        analogWrite(ledPin[2],ledColor[2]*ledBrightness/100);

    }

    //  The LED is switched off
    else
    {

        //  Write zeros to all LED pins
        analogWrite(ledPin[0],0);
        analogWrite(ledPin[1],0);
        analogWrite(ledPin[2],0);

    }

}

//  Initializes the serial port
void setup ( void )
{

    //  Initialize serial port
    Serial.begin(9600);

    //  Initialize random numbers generator
    randomSeed(analogRead(9));

    //  Switch on the LED with default color and brightness
    updateLedColor();

}

//  Reads commands from serial port and updates led color and brightness
void loop ( void )
{

    //  Processes input commands
    processInputCommands();

    //  When in auto mode
    if ( autoMode )
    {

        //  Alter LED color automatically
        performColorTransition();

    }

}
