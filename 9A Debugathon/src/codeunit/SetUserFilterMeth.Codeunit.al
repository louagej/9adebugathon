codeunit 50000 "PTE_SetUserFilter Meth"
{
    internal procedure SetUserFilter(var SalesInvoice: Record "Sales Header")
    var
        IsHandled: Boolean;
    begin
        OnBeforeSetUserFilter(SalesInvoice, IsHandled);

        DoSetUserFilter(SalesInvoice, IsHandled);

        OnAfterSetUserFilter(SalesInvoice);
    end;

    //[NonDebuggable]
    local procedure DoSetUserFilter(var SalesInvoice: Record "Sales Header"; IsHandled: Boolean)
    begin
        if IsHandled then
            exit;
        if UserId() = 'ADMIN' then
            exit;
        SalesInvoice.FilterGroup(2);
        SalesInvoice.SetRange("Assigned User ID", UserId());
        SalesInvoice.FilterGroup(0);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetUserFilter(var SalesInvoice: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetUserFilter(var SalesInvoice: Record "Sales Header")
    begin
    end;
}