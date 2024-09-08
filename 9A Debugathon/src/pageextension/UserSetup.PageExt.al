pageextension 50001 "PTE_User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("PTE_Fire Posting Error"; Rec."PTE_Fire Posting Error")
            {
                ApplicationArea = All;
            }
        }
    }
}