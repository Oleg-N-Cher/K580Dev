MODULE MakeLvov; (** portable *)

IMPORT
  SYSTEM, IO := Console, Cmd := CmdLine, Files, TapeLVT;

CONST
  CodeMaxSize = 0C000H; (* {0H..0BFFFFH} *)

VAR
  name: Cmd.String; (* A tape/code name. *)
  code: ARRAY CodeMaxSize OF SYSTEM.BYTE; codeLen: INT32;
  codeStartAddr: INT32;
  codeFile: Files.FileToRead;
  tap: TapeLVT.TapeFile;

PROCEDURE WriteStrLn (str: ARRAY OF CHAR);
BEGIN
  IO.WriteStr(str); IO.WriteLn;
END WriteStrLn;

PROCEDURE CreateLVT;
  VAR binName, tapName: Cmd.String;
BEGIN
  (* LOAD CODE: *)
  binName := name + ".bin";
  codeFile.OpenToRead(binName);
  IF codeFile.error OR codeFile.end THEN
    IO.WriteStr("Can't open file."); IO.WriteLn; HALT(1)
  END;
  codeLen := 0;
  WHILE ~ (codeFile.error OR codeFile.end) DO
    code[codeLen] := codeFile.ReadByte(); INC(codeLen);
  END;
  IF codeFile.error THEN
    codeFile.Close;
    IO.WriteStr("Can't read file."); IO.WriteLn; HALT(1)
  END;
  codeFile.Close;

  (* SAVE CODE: *)
  tapName := name + ".lvt";
  tap.ReCreate(tapName);
  IF tap.error THEN
    IO.WriteStr("Can't create tape file"); IO.WriteLn; HALT(1)
  END;
  tap.SaveCode(name, codeStartAddr, codeLen, @code);
  tap.Finalize;
  IF tap.error THEN
    IO.WriteStr("Can't save tape file"); IO.WriteLn; HALT(1)
  END;
END CreateLVT;

BEGIN (*$MAIN*)
  WriteStrLn("MakeLvov v1.0: convert a binary file to Lvov .lvt format");
  WriteStrLn("Copyright (C) 2021 Oleg N. Cher, VEDAsoft Oberon Club" );
  WriteStrLn("  https://github.com/Oleg-N-Cher/K580Dev");
  IO.WriteLn;
  CASE Cmd.ParamCount OF
  | 1: (* One parameter as input binary file name and output tape name: *)
    Cmd.GetParam(1, @name); codeStartAddr := 0; CreateLVT;
  | 2: (* Two parameters as input binary file name and code address: *)
    Cmd.GetParam(1, @name); Cmd.GetParamInt(2, @codeStartAddr); CreateLVT;
  ELSE (* ShowUsage: *)
    WriteStrLn("Usage: makelvov filename [starting address]");
    WriteStrLn("  Example: makelvov mygame 16384"); HALT(1)
  END;
END MakeLvov.
