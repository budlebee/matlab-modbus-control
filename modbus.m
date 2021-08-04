instrreset;
clear all; 
close all; 
clc; 
% remove any remaining serial objects to prevent serial issues
disp('BEGIN PROGRAM');
% Initialize Serial Port Object [s]
s = serial('COM3');
% Specify connection parameters
set(s,'BaudRate',9600,'DataBits',8,'StopBits',1,'Parity','None','Timeout',1);
%Open serial connection
fopen(s);
% Specify Terminator - not used for binary mode (RTU) writing
s.terminator = 'CR/LF';
% Set read mode
set(s,'readasyncmode','continuous');
%Check Open serial connection
s.Status
% RUN and COPY hexadecimal array from SimplyModbus software as example
% SimplyModbus IN  [01 03 00 00 00 03 05 CB] 
% Observe the output as result from SimplyModbus software 
% SimplyModbus OUT [01 03 06 01 90 01 16 00 00 00 81]
request = uint8(hex2dec(['01'; '03'; '00'; '00'; '00'; '03'; '05'; 'CB']));
% D = hex2dec(hexStr)은 hexStr로 표현되는 16진수 정수를 그에 상응하는 10진수로 변환하고, 이를 배정밀도 부동소수점 값으로 반환.

fwrite(s, request); %start in dec
% fwrite(fileID,A)는 배열 A의 요소를 이진 파일에 열 순서대로 8비트의 부호 없는 정수로 씁니다. 파일 ID fileID로 이진 파일을 지정합니다. fileID 값은 fopen으로 파일을 열어 구할 수 있습니다. 쓰기가 끝나면 fclose(fileID)를 호출하여 파일을 닫습니다.
outdec = fread(s);
outhex = dec2hex(outdec);
outstr = reshape(outhex.',1,[]); %return line string of array hexadecimal e.g.: '010306019000EB0000908D'
SP = hex2dec(outstr(7:10))*0.1 %Variable SetPoint de controler
PV = hex2dec(outstr(11:14))*0.1 %Real temperature PV
MV = hex2dec(outstr(15:18))*0.1 %Variable MV
fclose(s);
delete(s);
clear s
disp('STOP')