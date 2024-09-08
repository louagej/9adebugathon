tableextension 50000 "PTE_User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "PTE_Fire Posting Error"; Boolean)
        {
            Caption = 'Fire Posting Error';
            ToolTip = 'If checked, the posting error will appear.';
            DataClassification = CustomerContent;
        }
    }
}