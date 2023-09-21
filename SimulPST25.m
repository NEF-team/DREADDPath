

panel = [1:25];

choice=[]; repeat=[];

for ii=1:80  % will make 80 choices
   r=rand(1,25);  c=find(r==max(r)); % select randomly one of the 25 holes
   %-use the index of the max proba as chocie number
   if length(choice)>=1 % this is to store the final choices and code repeats as negative numbers
       if length(find(choice==c))>=1
         choice=[choice;-c];
       else
         choice=[choice;c];
       end
   else
        choice=[choice;c];
   end
   
end

tc = find(choice>0);
trep= find(choice<0);
subplot(2,2,1);plot(tc,choice(tc),'-o','color','blue'); title('random selection');hold on
plot(trep,choice(trep),'-*','color','red');legend({'choice','repeat'});

choice=[]; repeat=[];

% here the simul is choosing in a linear way but with some noise

for jj=1:3 %number of repeat of the 25 holes
   for c=1:25  % select from hole 1 to 25
       %random noise
       noise=0.3; %will select something else in 20% cases
       r1=rand(); 
       if r1 >= 1-noise
       r2=rand(1,25); c=find(r2==max(r2));%here does the random selection -use the index of the max proba as chocie number
       end
       
   if length(choice)>=1
       if length(find(choice==c))>=1
         choice=[choice;-c];
       else
         choice=[choice;c];
       end
   else
        choice=[choice;c];
   end
  
   end
end

tc = find(choice>0);
trep= find(choice<0);
subplot(2,2,2);plot(tc,choice(tc),'-o','color','blue'); title('noisy linear selection'); 
hold on
plot(trep,choice(trep),'-*','color','red')


% noisy selection with some memory 
choice=[]; repeat=[];


for jj=1:3 %number of repeat of the 25 holes
    choiceseries=randsample(25,25); %produce a list of choices with no repeat
   for c=1:25  % index to select from choice series
       %random noise
       noise=0.3; %will select something else (potentially repeat) in proba=noise cases
       r1=rand(); 
       if r1 >= 1-noise
       r2=rand(1,25); c=find(r2==max(r2)); %here does the random selection -use the index of the max proba as chocie number
       else
       c=choiceseries(c) % if not random take the current choice from list
       end
       
   if length(choice)>=1
       if length(find(choice==c))>=1
         choice=[choice;-c];
       else
         choice=[choice;c];
       end
   else
        choice=[choice;c];
   end
  
   end
end


tc = find(choice>0);
trep= find(choice<0);
subplot(2,2,3);plot(tc,choice(tc),'-o','color','blue'); title('all targets with noisy memory');hold on
plot(trep,choice(trep),'-*','color','red');legend({'choice','repeat'});
