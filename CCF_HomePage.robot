*** Settings ***
Library           Browser           auto_closing_level=MANUAL   enable_presenter_mode={"duration": "300 milliseconds", "width": "3px", "style": "dotted", "color": "red"}

*** Test Cases ***
CCF Home Page
    New Browser                chromium
    New Page                   https://mabanque.ccf.fr
    Wait For Response
    Sleep                      3 s
    ${url}       Get Url
    IF    "${url}" == "https://mabanque.ccf.fr/public/attente"
        Log To Console    Message d'attente
    ELSE
        Get Text    ux-text[tag='h2']       ==      Votre espace client CCF
    END

CCF Check FAQ
    ${url}       Get Url
    IF    "${url}" != "https://mabanque.ccf.fr/public/attente"
        Run Keyword And Continue On Failure     Get Text    contextualized-faq-banner ux-text[tag='p']      ==      Ces sujets pourraient vous intéresser
        Run Keyword And Continue On Failure     Get Text    div#st-faq-context button span.question-item-title>>nth=0                ==     Comment me connecter à mon Espace Client CCF la première fois ?
        Run Keyword And Continue On Failure     Get Text    div#st-faq-context button span.question-item-title>>nth=1                ==     Identifiant de connexion perdu ou oublié : comment le retrouver ?
        Run Keyword And Continue On Failure     Get Text    div#st-faq-context button span.question-item-title>>nth=3                ==     Mot de passe oublié : Comment le réinitialiser?
        Run Keyword And Continue On Failure     Get Text    div#st-faq-context button span.question-item-title>>nth=2                ==     Accès bloqué : Comment procéder ?
    END

*** Keywords ***
Tout accepter
    Wait For Elements State     div.didomi-popup-view    visible       timeout=10 s
    Wait For Elements State     div.didomi-popup-view \#didomi-notice-agree-button    visible       timeout=10 s
    Click       \#didomi-notice-agree-button