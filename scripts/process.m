% get data from file & data fft

A_f0=3*10^13;  % A_f0=1/delta_t
workpath=pwd;


% get data from file
dat1=getTDSdata('air');
dat2=getTDSdata('sample');

% cut dat1|2 vector here
% dat1=dat1(1:920);
% dat2=dat2(1:920);

% adding zeroes
% for i=601:20000
%     dat1(i)=0;
%     dat2(i)=0;
% end

% construct frequency vector
dat_N=length(dat1);
dat_f=(0:dat_N/2-1)';
dat_f=dat_f.*(A_f0/dat_N);

% fft of data
dat1_fft=fft(dat1);
dat1_fft=dat1_fft(1:dat_N/2);
dat1_phase=unwrap(angle(dat1_fft));
dat2_fft=fft(dat2);
dat2_fft=dat2_fft(1:dat_N/2);
dat2_phase=unwrap(angle(dat2_fft));

% calculate transmission
T=dat2_fft./dat1_fft;

% caluculate n,k (single iteration)
% pp=@(n,T,f,L)(4*n)/(n+1)^2*exp(-1i*(n-1)*2*pi*f*L/(3*10^8))-T;
% solution=[];
% for i=1:(dat_N/2)
%     solution(i)=fsolve(pp,10,[],0.4943-0.5361i,10^12,0.0005);
% end
% solution=solution';




