table 50000 "PTE_Debugathon Result"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Ranking No.';
            ToolTip = 'The ranking number of the result.';
        }
        field(2; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'User ID';
            ToolTip = 'The user ID of the result.';
        }
        field(3; "User Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'User Name';
            ToolTip = 'The user name of the result.';
        }
        field(4; "Time Difference"; Duration)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Time Difference';
            ToolTip = 'The time difference between Ranking No. 1 and this result.';
        }
        field(5; "Medal"; Text[50])
        {
            Caption = 'Medal';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    internal procedure CreateNewRanking()
    var
        UserInfo: Record User;
    begin
        Clear(Rec);
        Rec."Entry No." := GetNextEntryNo();
        Rec."User ID" := CopyStr(UserId(), 1, MaxStrLen(Rec."User ID"));
        UserInfo.Reset();
        UserInfo.SetRange("User Name", Rec."User ID");
        if UserInfo.FindFirst() then
            Rec."User Name" := UserInfo."Full Name"
        else
            Rec."User Name" := Rec."User ID";
        Rec."Time Difference" := GetDurationDifference();
        Rec.Medal := GetMedal(Rec."Entry No.");
        Rec.Insert(true);
    end;

    local procedure GetNextEntryNo(): Integer
    var
        DebugathonResult: Record "PTE_Debugathon Result";
    begin
        DebugathonResult.Reset();
        if DebugathonResult.FindLast() then
            exit(DebugathonResult."Entry No." + 1)
        else
            exit(1);
    end;

    local procedure GetDurationDifference(): Duration
    var
        DebugathonResult: Record "PTE_Debugathon Result";
    begin
        if not DebugathonResult.Get(1) then
            exit(0);
        exit(CurrentDateTime() - DebugathonResult.SystemCreatedAt);
    end;

    local procedure GetMedal(EntryNo: Integer): Text[50]
    begin
        case EntryNo of
            1:
                exit('🥇 Gold');
            2:
                exit('🥈 Silver');
            3:
                exit('🥉 Bronze');
            else
                exit('');
        end;
    end;

}