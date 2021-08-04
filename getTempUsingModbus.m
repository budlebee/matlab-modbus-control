clear all; 
close all; 
clc; 
%Create the MODBUS object, using TCP/IP.
m = modbus('tcpip', '192.168.2.1', 502);
threshold = 200;
%{
m = 

   Modbus TCPIP with properties:

    DeviceAddress: '192.168.2.1'
             Port: 502
           Status: 'open'
       NumRetries: 1
          Timeout: 10 (seconds)
        ByteOrder: 'big-endian'
        WordOrder: 'big-endian'
  %}

%The humidity sensor does not always respond instantly, so increase the timeout value to 20 seconds.
m.Timeout = 20;

thresholdTemp = 200;
timeInterval = 1;

%The temperature sensor is connected to a holding register at address 1 on the board. Read 1 value to get the current temperature reading. Since temperature value is a double, set the precision to a double.
for idx = 1:5
    disp(idx);
    temp = read(m,'holdingregs',1,1,'double');
    % read(m,target,address,count,serverId,precision)
    % 일단 온도가 계속 오르는 중이면 대기. 어느정도 시간이 지났는데 
    powerOn(temp, thresholdTemp);
    pause(timeInterval);
    
end

%{
    ans = 
   46.7
    %}
 
position = powerOn(temp);
%The humidity sensor is connected to the holding register at address 5 on the board. Read 1 value to get the current humidity reading.
read(m,'holdingregs',5,1,'double')


function power = powerOn(temp, threshold)
    if temp < threshold
        % power supply 의 전력을 상승시키는 함수 호출
        power = up;
    else 
        power = down;
    end
end
