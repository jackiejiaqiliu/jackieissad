n=1000;
m=100;
storagetimer = 6;
timeinterval = 50000;
load("Cap99_U.mat",'Cap99_U');
load("Cap1_U.mat",'Cap1_U');

%P_Counter_C = zeros(1,storagetimer*timeinterval);
%R_Counter_C = zeros(1,storagetimer*timeinterval);

bigr = zeros(n,storagetimer*timeinterval);
bigp = zeros(m,storagetimer*timeinterval);
bigeconrate=zeros(1,storagetimer*timeinterval);
%load("P_U.mat",'P_U');
for i = 1:storagetimer
%load("1storage_constraint"+num2str(bigtimer)+".mat",'r','c','pi');
load("Newstorage8_unconstraint"+num2str(i)+".mat",'r_record','p_record','econrate_record','capFrac_record');
bigr(:,(i-1)*timeinterval+1:i*timeinterval) = r_record;
bigp(:,(i-1)*timeinterval+1:i*timeinterval) = p_record;
bigeconrate(:,(i-1)*timeinterval+1:i*timeinterval) = econrate_record;
bigcap(:,(i-1)*timeinterval+1:i*timeinterval) = capFrac_record;
end


for j=1:storagetimer*timeinterval-1
    for i = 1:1000     
        bigrrate_U(i,j+1) = (bigr(i,j+1)-bigr(i,j))/bigr(i,j);
    end
end

finalrate_U=bigrrate_U(:,storagetimer*timeinterval-5:storagetimer*timeinterval);
%finalcap_U=bigcap(:,storagetimer*timeinterval-5:storagetimer*timeinterval);

% P_Counter_U = 0;
% for j=1:100
%     if (bigp(j,storagetimer*timeinterval)>10^(-13))
%         P_Counter_U = P_Counter_U+1;
%     end
% end



% 
% P_U(2,2)=P_Counter_U;
% save("P_U.mat",'P_U');
 
 
%  R_Counter_U=0;
% for i = 1:1000
%     if ((finalrate_U(i,1))>10^-5) &&(abs(finalrate_U(i,1)-finalrate_U(i,6))<10^-7)
%         R_Counter_U = R_Counter_U+1;
%     end
% end
%
% Number=R_Counter_U
%  

% lastP = bigp(:,storagetimer*timeinterval-5:storagetimer*timeinterval);
% lastP_Sorted = sort(lastP,1,'descend');

% secondlastP= bigp(:,5*timeinterval);
% secondlastP_Sorted = sort(secondlastP,1,'descend');
% 
% lastR = bigr(:,storagetimer*timeinterval-5:storagetimer*timeinterval);
% lastR_Sorted = sort(lastR,1,'descend');
%  
% lastRate = bigrrate_U(:,storagetimer*timeinterval-5:storagetimer*timeinterval);
% lastRate_Sorted = sort(lastRate,1,'descend');
%  
% secondlastRate=bigrrate_U(:,5*timeinterval-5:5*timeinterval);
% secondlastRate_Sorted= sort(secondlastRate,1,'descend');

lastCap = bigcap(:,storagetimer*timeinterval-5:storagetimer*timeinterval);
lastCap_Sorted = sort(lastCap,1,'descend');

Cap_Cumulative = zeros(1000,1);
Cap_Cumulative(1,1)=lastCap_Sorted(1,6);
for i=2:1000
Cap_Cumulative(i,1)=Cap_Cumulative(i-1,1)+lastCap_Sorted(i,6);
end

i=1;
while(Cap_Cumulative(i,1)<0.99)
    i=i+1;
end

Cap99Percent_U=i
Cap99_U(8,3)=Cap99Percent_U;
Cap1Percent_U=Cap_Cumulative(n/100,1)
Cap1_U(8,3)=Cap1Percent_U;

Cap99_U
Cap1_U
save("Cap99_U.mat",'Cap99_U');
save("Cap1_U.mat",'Cap1_U');

