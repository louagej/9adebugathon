codeunit 50002 "PTE_Debugathon Event Listener"
{
    SingleInstance = true;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure "Sales-Post_OnBeforePostSalesDoc"(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        UserSetup: Record "User Setup";
        AdminLbl: Label 'ADMIN', Locked = true;
        TheDebugathonErrorLbl: Label 'Find and fix the 🐛 debugathon error', Locked = true;
    begin
        if IsHandled then
            exit;
        if UserId() = AdminLbl then
            exit;
        UserSetup.Get(UserId());
        if UserSetup."PTE_Fire Posting Error" then
            Error(TheDebugathonErrorLbl);
    end;


}