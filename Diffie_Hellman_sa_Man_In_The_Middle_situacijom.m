clc
clear all
close all

%% Generisanje tajnog kljuca Z
disp('----------------------------------------------');
disp('"Diffie-Hellman"-ov algoritam razmene kljuceva');
disp('----------------------------------------------');

%Unos vrednosti p i q, pri cemu je p prost broj, a g je izmedju 0 i p-1
dobar_unos = 0;
while dobar_unos == 0
    p = input('Unesite prost broj p: ');
    g = input(['Unesite pozitivan broj g koji je manji od ' num2str(p-1) ': ']);
    pp = isprime(p); %ispitivanje da li je p prost broj
    gg = g>0 && g<(p-1); %ispitivanje da li je g u granicama
	if pp == 0
        disp(' ');
        disp('Unesite ispravan broj p!');
        disp(' ');
    end
    if gg == 0
        disp(' ');
        disp('Unesite ispravan broj g!');
        disp(' ');
    end
    dobar_unos = pp & gg;
end

disp(' ');
disp('***Tajni kljucevi***'); %izabrano da budu ograniceni na 10 zbog Matlaba-gresi pri zaokruzivanju kod prevelikih brojeva!
a = randi([1 10]);%Tajni kljuc Alise
b = randi([1 10]);%Tajni kljuc Boba
disp(['Alisin tajni kljuc a: ' num2str(a)]);
disp(['Bobov tajni kljuc b: ' num2str(b)]);

disp(' ');
disp('***Javni kljucevi***');
%Izracunavanje javnih kljuceva
A = power(g,a);
A = mod(A,p);
B = power(g,b);
B = mod(B,p);
disp(['Alisin Javni kljuc A: ' num2str(A)]);
disp(['Bobov javni kljuc B: ' num2str(B)]);

disp(' ');
disp('***Izracunavanje kljuceva sesije***');
%Alisin kljuc sesije
Za = power(B,a);
Za = mod(Za,p);
%Bobov kljuc sesije
Zb = power(A,b);
Zb = mod(Zb,p);

disp(['Alisin kljuc Z: ' num2str(Za)]);%Kljuc koji je izracunala Alisa
disp(['Bobov kljuc Z: ' num2str(Zb)]);%Kljuc koji je izracunao Bob




%% Man in the middle
disp(' ');
disp('-----------------------------------------------------');
disp('"Diffie-Hellman"-ov algoritam sa primerom presretanja');
disp('-----------------------------------------------------');

%Tajni kljuc presretaca
c = randi([1 10]);
disp(['Tajni kljuc presretaca c: ' num2str(c)]);
%Javni kljuc presretaca
C = power(g,c);
C = mod(C,p);
disp(['Javni kljuc presretaca C: ' num2str(C)]);
disp(' ');
disp('***Izracunavanje kljuceva sesije - Man-in-the-middle situacija***');

%Alisin kljuc sesije
Z1a = power(C,a);
Z1a = mod(Z1a,p);
%Presretacev kljuc sesije ka Alisi
Z1c = power(A,c);
Z1c = mod(Z1c,p);
disp(' ');
disp(['Alisa prima javni kljuc presretaca i racuna kljuc sesije Z1: ' num2str(Z1a)]);%Kljuc koji je izracunala Alisa
disp(['Presretac na osnovu Alisinog javnog kljuca racuna kljuc sesije Z1: ' num2str(Z1c)]);%Kljuc koji je izracunao presretac

%Bobov kljuc sesije
Z2b = power(C,b);
Z2b = mod(Z2b,p);
%Presretacev kljuc sesije ka Bobu
Z2c = power(B,c);
Z2c = mod(Z2c,p);
disp(' ');
disp(['Bob prima javni kljuc presretaca i racuna kljuc sesije Z2: ' num2str(Z2b)]);%Kljuc koji je izracunao Bob
disp(['Presretac na osnovu Bobovog javnog kljuca racuna kljuc sesije Z2: ' num2str(Z2c)]);%Kljuc koji je izracunao presretac