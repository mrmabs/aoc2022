{$mode objfpc}{$H+}
uses
  StrUtils, SysUtils;
var 
  MovesFile: TextFile;
  s: string;
  d: string;
  line: array of string;
  map: array of string;
  dir: string;
  dist: integer;
  step: integer;
  hx: integer;
  hy: integer;
  tx: integer;
  ty: integer;
  txy: string;
  counter: integer;
  dummy: string;
begin
  AssignFile(MovesFile, 'day9-input.txt');
  d := ' ';
  hx := 1;
  hy := 1;
  tx := 1;
  ty := 1;
  //map[0] := '';

  try
    reset(MovesFile);    //Reopen the file for reading
	while not eof(MovesFile) do
	begin
		readln(MovesFile, s);
		line := SplitString(s, d);
		dir := line[0];
		dist := StrToInt(line[1]);
		//writeln(dir, dist);
		step := 0;
		while (step < dist) do
		begin
			// move head
			case dir of
				'U': inc(hy); //hy := hy - dist;
				'D': dec(hy); // := hy + dist;
				'L': dec(hx); // := hx - dist;
				'R': inc(hx); //hx := hx + dist;
			end;
			if (abs(hx - tx) > 1) or (abs(hy - ty) > 1) then
			begin
				// which direction to move tail
				if (hx - tx) <= -1 then
				begin
					//writeln('hx-tx -1');
					dec(tx);
				end;
				if (hx - tx) >= 1 then
				begin
					//writeln('hx-tx +1');
					inc(tx);
				end;
				if (hy - ty) <= -1 then
				begin
					//writeln('hy-ty -1');
					dec(ty);
				end;
				if (hy - ty) >= 1 then
				begin
					//writeln('hy-ty +1');
					inc(ty);
				end;
			end;
			//writeln(hx, 'H', hy);
			//writeln(tx, 'T', ty);
			inc(step);
			txy := IntToStr(tx) + 'X' + IntToStr(ty);
			if not (txy in map) then
			begin
				map := Concat(map, [txy]);
			end;
		end;
	end; 
   
  finally
    CloseFile(MovesFile);
    
    counter := 0;
    for dummy in map do
		inc(counter);
	writeln('Number: ', counter);
  end
end.
