*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Read_Excel_For_Test
    [Arguments]                           ${fileExcel}                 ${sheetName}                   ${rowNo}
    ExcelLibraryV2.Open Excel Document    ${fileExcel}                 Test                           True
    ${sheets}=                            Get List Sheet Names
    List Should Contain Value             ${sheets}                    ${sheetName}
    @{HEAD}                               Read Excel Row               row_num=1                      sheet_name=${sheetName}
    @{DATA}                               Read Excel Row               row_num=${rowNo}               sheet_name=${sheetName}
    Log List                              ${HEAD}
    Log List                              ${DATA}
    Close All Excel Documents
    ############
    ${Test_Data}                          BuiltIn.Create Dictionary
    ${length}                             BuiltIn.Get Length           ${DATA}
    FOR                                   ${i}                         IN RANGE                       0                          ${length}
    Set To Dictionary                     ${Test_Data}                 ${HEAD[${i}]}=${DATA[${i}]}
    END
    Log Dictionary                        ${Test_Data}
    [Return]                              ${Test_Data}

Write_Result_Status_To_Excel
    [Arguments]                  ${fileExcel}                 ${sheetName}        ${rowNo}            ${status}
    Open Excel Document          ${fileExcel}                 Test
    Log                          ${status}
    Run Keyword If               ${status}==True              Write Excel Cell    row_num=${rowNo}    col_num=1                  value=PASSED    sheet_name=${sheetName}
    Run Keyword If               ${status}==False             Write Excel Cell    row_num=${rowNo}    col_num=1                  value=FAILED    sheet_name=${sheetName}
    Write Excel Cell             row_num=${rowNo}             col_num=3           value=${actual}     sheet_name=${sheetName}
    Save Excel Document          ${fileExcel}
    Close All Excel Documents
    [Teardown]                   Close All Excel Documents

Write_Result_Status_To_Excel_For_Check_data
    [Arguments]            ${fileExcel}        ${sheetName}        ${rowNo}            ${status}
    Log                    ${status}
    Run Keyword If         ${status}==True     Write Excel Cell    row_num=${rowNo}    col_num=1                  value=PASSED    sheet_name=${sheetName}
    Run Keyword If         ${status}==False    Write Excel Cell    row_num=${rowNo}    col_num=1                  value=FAILED    sheet_name=${sheetName}
    Write Excel Cell       row_num=${rowNo}    col_num=3           value=${actual}     sheet_name=${sheetName}
    Save Excel Document    ${fileExcel}

Create File Excel
    [Arguments]              ${doc_id}           ${file_name}
    Create Excel Document    doc_id=${doc_id}
    Save Excel Document      ${file_name}

Write_Result_Get_Doc_To_Excel
    [Arguments]                  ${fileExcel}                 ${sheetName}        ${rowNo}                   ${status}
    Open Excel Document          ${fileExcel}                 Test
    Log                          ${status}
    Run Keyword If               ${status}==True              Write Excel Cell    row_num=${rowNo}           col_num=1                  value=PASSED    sheet_name=${sheetName}
    Run Keyword If               ${status}==False             Write Excel Cell    row_num=${rowNo}           col_num=1                  value=FAILED    sheet_name=${sheetName}
    Write Excel Cell             row_num=${rowNo}             col_num=3           value=${PolicySigned}      sheet_name=${sheetName}
    Write Excel Cell             row_num=${rowNo}             col_num=4           value=${PolicyUnsigned}    sheet_name=${sheetName}
    Save Excel Document          ${fileExcel}
    Close All Excel Documents
    [Teardown]                   Close All Excel Documents


Write_Result_Status_To_Excel_Header
    [Arguments]                  ${fileExcel}                 ${sheetName}        ${rowNo}            ${status}
    Open Excel Document          ${fileExcel}                 Test
    Log                          ${status}
    Run Keyword If               ${status}==True              Write Excel Cell    row_num=${rowNo}    col_num=1                  value=PASSED    sheet_name=${sheetName}
    Run Keyword If               ${status}==False             Write Excel Cell    row_num=${rowNo}    col_num=1                  value=FAILED    sheet_name=${sheetName}
    Save Excel Document          ${fileExcel}
    Close All Excel Documents
    [Teardown]                   Close All Excel Documents

Write_Result_Status_To_Excel_Log
    [Arguments]                  ${fileExcel}                 ${sheetName}        ${rowNo}            ${status}
    Open Excel Document          ${fileExcel}                 Test
    Log                          ${status}
    Run Keyword If               ${status}==True              Write Excel Cell    row_num=${rowNo}    col_num=1                  value=PASSED    sheet_name=${sheetName}
    Run Keyword If               ${status}==False             Write Excel Cell    row_num=${rowNo}    col_num=1                  value=FAILED    sheet_name=${sheetName}
    Write Excel Cell             row_num=${rowNo}             col_num=4           value=${actual}     sheet_name=${sheetName}
    Save Excel Document          ${fileExcel}
    Close All Excel Documents
    [Teardown]                   Close All Excel Documents