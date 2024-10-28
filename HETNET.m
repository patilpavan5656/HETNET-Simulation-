% Parameters 
numUsers = 100;               % Number of users 
numMacroBS = 5;             % Number of macro base stations 
numSmallCells = 10;         % Number of small cells (pico/femto) 
areaSize = 1000;                % Simulation area (meters x meters) 
macroBSPower = 40;         % Macro BS transmit power (Watts) 
smallCellPower = 6;           % Small cell transmit power (Watts) 
noisePower = -174;            % Noise power in dBm/Hz 
bandwidth = 10e6;             % Bandwidth (10 MHz) 
frequency = 2e9;                % Frequency (2 GHz) 
 
% Deploy Base Stations (Macro and Small Cells) 
macroBSPositions = areaSize * rand(numMacroBS, 2);   % 
Random positions of macro base stations 
smallCellPositions = areaSize * rand(numSmallCells, 2); % 
Random positions of small cells 
 
% Deploy Users Randomly in the Area 
userPositions = areaSize * rand(numUsers, 2);   % Random 
positions of users 
 
% Path Loss Model (Urban Macro + Small Cells) 
% Using a simplified path loss model: L = 128.1 + 
37.6*log10(d) [dB] at 2 GHz 
pathLossModel = @(d) 128.1 + 37.6*log10(d); % Distance
based path loss (3GPP Urban Macro) 
 
% Calculate SINR for each user from each base station 
SINR = zeros(numUsers, numMacroBS + numSmallCells);  % 
SINR matrix 
 
for userIdx = 1:numUsers 
    for bsIdx = 1:numMacroBS 
        % Calculate distance from user to macro BS 
        distance = norm(userPositions(userIdx,:) - 
macroBSPositions(bsIdx,:)); 
        % Calculate path loss 
        pathLoss = pathLossModel(distance); 
        % Received power (in dBm): P_rx = P_tx - L 
        rxPowerMacro = 10*log10(macroBSPower) - pathLoss; 
        % SINR = (P_rx - Noise) 
        SINR(userIdx, bsIdx) = rxPowerMacro - noisePower; 
    end 
    
 
 
12 
 
 for bsIdx = 1:numSmallCells 
        % Calculate distance from user to small cell 
        distance = norm(userPositions(userIdx,:) - 
smallCellPositions(bsIdx,:)); 
        % Calculate path loss 
        pathLoss = pathLossModel(distance); 
        % Received power (in dBm): P_rx = P_tx - L 
        rxPowerSmall = 10*log10(smallCellPower) - pathLoss; 
        % SINR = (P_rx - Noise) 
        SINR(userIdx, numMacroBS + bsIdx) = rxPowerSmall - 
noisePower; 
    end 
end 
 
% User Association (Choose the best SINR for each user) 
[bestSINR, connectedBS] = max(SINR, [], 2); 
 
% Display Results 
disp('User connections:'); 
for userIdx = 1:numUsers 
    if connectedBS(userIdx) <= numMacroBS 
        disp(['User ' num2str(userIdx) ' connected to Macro BS ' 
num2str(connectedBS(userIdx)) ' with SINR = ' 
num2str(bestSINR(userIdx)) ' dB']); 
    else 
        disp(['User ' num2str(userIdx) ' connected to Small Cell ' 
num2str(connectedBS(userIdx) - numMacroBS) ' with SINR = ' 
num2str(bestSINR(userIdx)) ' dB']); 
    end 
end 
 
% Plot Base Station and User Locations 
figure; 
hold on; 
scatter(macroBSPositions(:,1), macroBSPositions(:,2), 100, 'r', 
'filled'); % Macro BS 
scatter(smallCellPositions(:,1), smallCellPositions(:,2), 50, 'g', 
'filled'); % Small cells 
scatter(userPositions(:,1), userPositions(:,2), 20, 'b'); % Users 
legend('Macro BS', 'Small Cell', 'Users'); 
xlabel('X Position (m)'); 
ylabel('Y Position (m)'); 
title('HetNet Simulation: Base Stations and Users'); 
grid on; 