*** Settings ***
Documentation       Template robot main suite.
Library           RPA.Database
Library           RPA.PDF
Library           String
Library           RPA.Windows
Library           OperatingSystem
Library    Collections
Suite Setup       Connect To Database     psycopg2   ${dbname}   ${dbusername}   ${dbpassword}   ${dbhost}   ${dbport}
Suite Teardown    Disconnect From Database

***Variables***
${dbname}       postgres
${dbusername}   postgres
${dbpassword}   root
${dbhost}       localhost
${dbport}       5432
${tblname}      tbl_rapport_journalier

${Message_erreur}     votre rapport du 12/12/20000 n'est pas coherent
${Message_succes}    rapport avec succes
@{List_nom_responsable}    Create Dictionary
@{my_dict}    Create Dictionary
@{Llist_rapport}    Create List
*** Tasks ***
Recuperer les donnees du rapport depuis la base de donnees et envoyer un mail au responsable avec une piece jointe pdf
    @{List_nom_responsable}        Lire base de donnees
    FOR    ${element}    IN    @{List_nom_responsable}
        Log    ${element}
       &{dictionnaire_rapports}    Create Dictionary    date= ${element}[jounee]    nom_responsable=${element}[nom_responsable] 
        FOR    ${key}    IN    @{dictionnaire_rapports}
            Log    ${key}=${dictionnaire_rapports}[${key}]
            IF    ${key}==
                Call Keyword
            ELSE
                
            END
        
        END

        # Append To List    ${Llist_rapport}    ${dictionnaire_rapports}
        # Log      ${Llist_rapport} 
    END
    # Log To Console     ${List_nom_responsable} 
    # Create a file
# dictionnaire
#     Lire dictionnaire
*** Keywords ***

Lire base de donnees
    @{list_rapports}            Query    Select * FROM ${tblname}
    [Return]    @{list_rapports}



    #  FOR    ${rapport}    IN    @{list_rapports}
    #     ${id}                     Set Variable    ${rapport}[id]
    #     ${nom_magasin}            Set Variable    ${rapport}[nom_magasin]
    #     ${nom_responsable}        Set Variable    ${rapport}[nom_responsable]
    #     ${date}                   Set Variable    ${rapport}[jounee]
    #     ${carte_bancaire}         Set Variable    ${rapport}[carte_bancaire]
    #     ${especes}                Set Variable    ${rapport}[especes]
    #     ${ticket_restaurant}      Set Variable    ${rapport}[ticket_restaurant]
    #     ${prelevement}            Set Variable    ${rapport}[prelevement]
    #     ${monnaie}                Set Variable    ${rapport}[apportmonnaie]
    #     ${total}                  Set Variable    ${carte_bancaire} + ${especes} +${ticket_restaurant}
    #     ${solde}                  Set Variable    ${prelevement}+${monnaie}
    #     ${verification}           Set Variable    ${${${total}}-${${solde}}}

    #     IF    ${verification} != 0
    #         Log    ${Message_erreur} ${date}
    #         # @{nom_responsable} = []
    #         FOR    ${i}    IN    @{list_rapports}
    #             Append To List    ${List_nom_responsable}    Value ${i}
    #             Log    ${List_nom_responsable}                
    #         END
    #     ELSE
    #         Log    ${Message_succes} ${date}
    #     END
    #  END

            
    # Log    ${Message_erreur} ${date}

    # ${content}=    Catenate
    # ...    <html>
    # ...    <head>
    # ...    <title>rapport</title>
    # ...    </head>
    # ...    <body>
    # ...    <h1>Le journal des rapports</h1> </br>
    # ...    <h2> Date : ${date} </h2>
    # ...    <ol>
    # ...    <li>${nom_responsable}</li>
    # ...    </ol>
    # ...    </body>
    # ...    </html>

    # Create File    mon_fichier.html    ${content}
    # #Run    wkhtmltopdf mon_fichier.html ${OUTPUT_DIR}${/}feuille_de_rapport.pdf

    # Html To Pdf    ${content}    ${OUTPUT_DIR}${/}feuille_de_rapport.pdf

# Lire dictionnaire

#     @{list_rapports}            Query    Select * FROM ${tblname}  
#     FOR    ${key}    IN    @{list_rapports}
#         ${value}    Set Variable    Value for     ${key}[jounee]
#         Set To Dictionary        &{my_dict}        ${key}        ${value}
        
#     END
#  Send Email