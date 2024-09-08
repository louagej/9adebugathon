permissionset 50000 "9A Debugathon Admin"
{
    Access = Internal;
    Assignable = true;
    Caption = '9A Debugathon Admin', Locked = true;
    Permissions = codeunit "PTE_Database Event Listener" = X,
        codeunit "PTE_Debugathon Event Listener" = X,
        codeunit "PTE_SetUserFilter Meth" = X,
        tabledata "PTE_Debugathon Result" = RIMD,
        table "PTE_Debugathon Result" = X;
}