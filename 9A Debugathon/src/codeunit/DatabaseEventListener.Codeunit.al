codeunit 50001 "PTE_Database Event Listener"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Table, Database::"User Setup", OnBeforeModifyEvent, '', false, false)]
    local procedure OnBeforeModifyUserSetup(var Rec: Record "User Setup"; var xRec: Record "User Setup"; RunTrigger: Boolean)
    var
        USerSetupModificationLbl: Label 'You can only modify your own user setup.';
        AdminLbl: Label 'ADMIN', Locked = true;
    begin
        if Rec.IsTemporary() then
            exit;
        if UserId() = AdminLbl then
            exit;
        if Rec."User ID" <> UserId() then
            Error(USerSetupModificationLbl);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure SalesPostOnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        DebugathonResult: Record "PTE_Debugathon Result";
    begin
        if (SalesInvHdrNo <> '') and (SalesHeader."Assigned User ID" = UserId()) then
            DebugathonResult.CreateNewRanking();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertSalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary() then
            exit;
        if Rec."Assigned User ID" = '' then
            Rec."Assigned User ID" := CopyStr(UserId(), 1, MaxStrLen(Rec."Assigned User ID"));
    end;



}