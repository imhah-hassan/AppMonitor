*** Settings ***
Library           Browser           auto_closing_level=SUITE
# enable_presenter_mode={"duration": "10 milliseconds", "width": "3px", "style": "dotted", "color": "red"}
Library           BuiltIn

*** Test Cases ***
Home
    New Browser            chromium
    new page               https://www.groupeonepoint.com
    Click                   //button[text()='Tout accepter']>>nth=0
    Run Keyword And Continue On Failure     Get Text    div.js-home-header-banner h1        ==      Onepoint est l’architecte des grandes transformations des entreprises et des acteurs publics

Nous Rejoindre    Click                   //a[text()='Nous rejoindre']>>nth=0
    Go To                   https://www.groupeonepoint.com/fr/rejoindre-onepoint/
    Run Keyword And Continue On Failure     Get Text    div.join_us h1        ==      Rejoignez-nous\xa0!

Voir toutes les offres
    Click                   //a[text()='Voir toutes nos offres']>>nth=0
    Run Keyword And Continue On Failure     Get Text    div[data-automation-id="headerTitle"] h1        ==      Carrières


