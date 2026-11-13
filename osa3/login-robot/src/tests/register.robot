*** Settings ***
Resource  resource.robot

*** Test Cases ***
Register With Valid Username And Password
    Input New Command
    Input Credentials  kalle  kalle123
    Output Should Contain  New user registered

Register With Already Taken Username And Valid Password
    Input New Command
    Input Credentials  kalle  kalle123
    Input New Command
    Input Credentials  kalle  kalle456
    Output Should Contain  User with username kalle already exists

Register With Too Short Username And Valid Password
    Input New Command
    Input Credentials  k  kalle456
    Output Should Contain  Username is too short

Register With Enough Long But Invalid Username And Valid Password
    Input New Command
    Input Credentials  k!ll!  kalle456
    Output Should Contain  Username is invalid

Register With Valid Username And Too Short Password
    Input New Command
    Input Credentials  kalle  kalle12
    Output Should Contain  Password is too short

Register With Valid Username And Long Enough Password Containing Only Letters
    Input New Command
    Input Credentials  kalle  kalleeee
    Output Should Contain  Password is invalid

*** Keywords ***
Input New Command
    Input  new
