page 50000 "PTE_Debugathon Results"
{
    ApplicationArea = All;
    Caption = 'Debugathon Results';
    RefreshOnActivate = true;
    PageType = List;
    SourceTable = "PTE_Debugathon Result";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ranking No. field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.', Comment = '%';
                }
                field("System Created At"; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the System Created At field.', Comment = '%';
                }
                field("Time Difference"; Rec."Time Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Difference field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ClearRanking)
            {
                ApplicationArea = All;
                Caption = 'Clear Ranking';
                Image = Delete;
                ToolTip = 'Removes all ranking records';
                Visible = UserIsAdmin;
                trigger OnAction()
                begin
                    if Confirm('Do you want to clear all ranking records?', false) then
                        Rec.DeleteAll();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ClearRanking_Promoted; ClearRanking)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        AdminLbl: Label 'ADMIN', Locked = true;
    begin
        if UserId() = AdminLbl then
            UserIsAdmin := true
        else
            UserIsAdmin := false;
    end;

    var
        UserIsAdmin: Boolean;
}
