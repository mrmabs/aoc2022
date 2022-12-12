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
  hx: array[0..10] of integer;
  hy: array[0..10] of integer;
  txy: string;
  counter: integer;
  dummy: string;
begin
  AssignFile(MovesFile, 'day9-input.txt');
  d := ' ';
  counter := 0;
  while counter <= 10 do
  begin
	hx[counter] := 12;
	hy[counter] := 6;
	inc(counter)
  end;

  try
    reset(MovesFile);    //Reopen the file for reading
	while not eof(MovesFile) do
	begin
		readln(MovesFile, s);
		line := SplitString(s, d);
		dir := line[0];
		dist := StrToInt(line[1]);
		writeln(dir, dist);
		step := 0;
		while (step < dist) do
		begin
			// move head
			case dir of
				'U': inc(hy[0]); //hy := hy - dist;
				'D': dec(hy[0]); // := hy + dist;
				'L': dec(hx[0]); // := hx - dist;
				'R': inc(hx[0]); //hx := hx + dist;
			end;

			counter := 1;
			while counter <= 9 do
			begin
				hwx[counter] := hx[counter];
				hwy[counter] := hy[counter];
				if (abs(hx[counter] - hx[counter - 1]) > 1) or (abs(hy[counter] - hy[counter - 1]) > 1) then
				begin
					// which direction to move tail
					if (hx[counter - 1] - hx[counter]) <= -1 then
					begin
						//writeln('hx-tx -1');
						dec(hx[counter]);
					end;
					if (hx[counter - 1] - hx[counter]) >= 1 then
					begin
						//writeln('hx-tx +1');
						inc(hx[counter]);
					end;
					if (hy[counter - 1] - hy[counter]) <= -1 then
					begin
						//writeln('hy-ty -1');
						dec(hy[counter]);
					end;
					if (hy[counter - 1] - hy[counter]) >= 1 then
					begin
						//writeln('hy-ty +1');
						inc(hy[counter]);
					end;
				end;
				inc(counter);
			end;
			inc(step);
			txy := IntToStr(hx[9]) + 'X' + IntToStr(hy[9]);
			if not (txy in map) then
			begin
				map := Concat(map, [txy]);
				writeln(txy);
			end;
		end;
	end; 
   
  finally
    CloseFile(MovesFile);
    
    counter := 0;
    for dummy in map do
		inc(counter);
		//writeln(dummy);
	writeln('Number: ', counter);
  end
end.
