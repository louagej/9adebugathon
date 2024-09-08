// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50000 "PTE_Sales Invoice List" extends "Sales Invoice List"
{
    trigger OnOpenPage();
    begin
        Rec.FilterGroup(2);
    end;
}

