clear all; 
close all; 
clc; 
%Create the MODBUS object, using TCP/IP.
%{
m = modbus('tcpip');
m.DeviceAddress = '192.168.2.1';
m.Port = 502;
m.Timeout = 20;

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


thresholdTemp = 200;
timeInterval = 1; % time interval 을 적당한 길이로 잡아야 할듯. 너무 짧으면 power 가 급격히 치솟는 문제가 생길것.
iterationRange = 1:10;

result_1 = zeros(1,11);
for idx = iterationRange
    disp(idx);
    %temp = read(m,'holdingregs',1,1,'double');
    % read(m,target,address,count,precision)
    % m을 타겟으로 삼아서, 어드레스 1번의 홀딩레지스터를 1개 읽어온다: 배정밀도 double 형식으로.
    
    % 온도가 어느정도 시간만에 수렴하는지를 몰라서 작성할 수가 없네.
    %if temp < thresholdTemp
        % 온도를 높이는 함수를 호출.
    %else 
        % 온도를 낮추는 함수를 호출.
    %end
    %temp 값을 배열에 집어넣자.
    %tempResult(idx) = temp
    tiledlayout(1,2) 
    
    nexttile
    result_1(idx) = randn(1,1);
    plot(result_1);
    title('temperature')
    
    nexttile
    bar(randn(1,1));
    title('power supply')
    
    drawnow;
    pause(timeInterval);
end


function power = powerOn(temp, threshold)
    if temp < threshold
        % power supply 의 전력을 상승시키는 함수 호출
        power = up;
    else 
        power = down;
    end
end
