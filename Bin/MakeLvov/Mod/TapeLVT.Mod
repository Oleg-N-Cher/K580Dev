MODULE TapeLVT;	(** portable *)

IMPORT
  SYSTEM, Files;

TYPE
  BYTE = SYSTEM.BYTE;
  WORD = INT32; (* Alias for INTEGER type to enhance the visibility. *)
  
  (* TAP format: *)
  TapeFile* = RECORD [notag]
    file: Files.FileToWrite;
    error-: BOOLEAN; (** Was there an error during the work? *)
    errcode-: WORD;  (** A code of the first occurred error. *)
  END;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) ReCreate* (tapeName: ARRAY OF CHAR);
BEGIN
  tap.file.OpenToWrite(tapeName);
  tap.error := tap.file.error; (* Выносим обработку ошибок на уровень выше. *)
END ReCreate;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveByte (byte: BYTE);
BEGIN
  IF ~tap.error THEN
    tap.file.WriteByte(byte); tap.error := tap.file.error;
  END;
END SaveByte;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveWord (word: WORD);
BEGIN
  ASSERT((word >= 0) & (word <= 0FFFFH)); (* word IN {0..65535} *)
  IF ~tap.error THEN
    tap.SaveByte(SHORT(SHORT(word MOD 100H))); tap.error := tap.file.error;
    IF ~tap.error THEN
      tap.SaveByte(SHORT(SHORT(word DIV 100H))); tap.error := tap.file.error;
    END;
  END;
END SaveWord;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveStr (str: ARRAY OF CHAR);
VAR
  i: INTEGER;
BEGIN
  i := 0;
  WHILE (str[i] # 0X) & (i < LEN(str)) DO 
    tap.SaveByte(SHORT(ORD(str[i]))); INC(i);
  END;
END SaveStr;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveName (name: ARRAY OF CHAR);
  (* Write a name (6 bytes, if less, filled with spaces). *)
VAR
  i, nameIdx: INTEGER;
BEGIN
  nameIdx := 0;
  FOR i := 0 TO 5 DO (* Cut a name, if its len > 6. *)
    IF (nameIdx <= LEN(name)) & (name[nameIdx] # 0X) THEN
      tap.SaveByte(SHORT(ORD(name[nameIdx])));
      INC(nameIdx);
    ELSE
      tap.SaveByte(SHORT(ORD(" ")));
    END;
  END;
END SaveName;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveCodeHeader (
  name: ARRAY OF CHAR; dataStartAddr, dataLength: INTEGER);
(*
CODE .LVT

+0x00   9               "LVOV/2.0/"     Первичная сигнатура .LVT-ленты
+0x09   1               0xD0            Вторичная .LVT сигнатура (Binary)
+0x0A   6               "......"        Имя ленты в КОИ7 (выравнено пробелами)
+0x10   2               0x????          Адрес начала размещения программы
+0x12   2               0x????          Адрес конца размещения программы
+0x14   2               0x????          Адрес точки запуска программы
+0x16   upto EOF        0x??, ...       Тело программы
*)
BEGIN
  tap.SaveStr("LVOV/2.0/");
  tap.SaveByte(0D0H);
  tap.SaveName(name);
  tap.SaveWord(dataStartAddr);
  tap.SaveWord(dataStartAddr + dataLength - 1);
  tap.SaveWord(dataStartAddr);
END SaveCodeHeader;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveDataBlock (
  dataLength: INTEGER; VAR data: ARRAY OF BYTE);
VAR
  i: INTEGER;
BEGIN
  FOR i := 0 TO dataLength - 1 DO tap.SaveByte(data[i]) END;
END SaveDataBlock;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) SaveCode* (
  name: ARRAY OF CHAR; startAddr, dataLength: INTEGER; VAR data: ARRAY OF BYTE);
BEGIN
  tap.SaveCodeHeader(name, startAddr, dataLength);
  tap.SaveDataBlock(dataLength, @data);
END SaveCode;

(*----------------------------------------------------------------------------*)
PROCEDURE (VAR tap: TapeFile) Finalize* ;
BEGIN
  tap.file.Close;
END Finalize;

(*============================================================================*)
END TapeLVT.

(*
  IMPORT TapeTAP;
  VAR
    tap: TapeTAP.TapeFile; data: ARRAY 4 OF BYTE;
  BEGIN
    data[0] := 3EX; data[1] := 41X; data[2] := 0D3X; data[3] := 0C9X;
    tap.ReCreate("mytape.lvt");
    tap.SaveCode("mycode", 26000, 4, data);
    tap.Finalize;
  END ...
*)

(* TODO:
  implement SaveDataBlock with Files.SaveBytes (incr. efficiency).
*)
