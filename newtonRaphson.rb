#!/usr/bin/ruby 
#
#  newtonRaphson.rb
#  
#  Copyright 2020 William Martinez Bas <metfar@gmail.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

####accessory functions to simplify the main
def input(text=nil); #text input (BASIC-like)
	if(text!=nil); then
		print(text);
	else;
		print("?");
	end;
	return(gets.chomp);
end;

def fn(a_n,val);#function to approximate a square root of val
	return(a_n-(a_n*a_n-val)/(2.0*a_n));
end;

def fmt(n=8);#create a format-string with n decimal precision
	return("%."+("%d"%n)+"f");
end;

def cmp(a,b);#comparison of float values with default format
	return((fmt() % a)==(fmt() % b));
end;


###### MAIN ########
def main();
	val=-1;
	while(val!=0); #main loop (while your choice is not to exit)
		print("\n-------------------\n\nf(x)=x² - S\n");
		print("\n a_n+1 = a_n - (a_n² - S)/(2*a_n) \n");
		
		begin;#try/catch for errors in user input 
			#ask for an input, convert it into floating point value, and store in val
			val=Float(input("\nValue of S to find it's square root? (0 to exit) \n"));
		rescue;
			print("Wrong value! Please, try again!!!\n\n");
			val=-1;#skip calculations
		end;
		step=0;#counter to know how many iterations will take to find a square root
		if(val>0); then #if it is a wrong value or 0 is chosen, it will skip this 
			tmp=0;
			f=1.0;#square roots starts trying with a_n=1
			tmpL=1.0;
			
			while(f<=val);
			#some approximations are not accurate, so the estimation loop will
			#calculate as long as the estimated value of the square is less
			#than the user input
				tmpL=tmp;#save the last temporal calculation to test it later
				tmp=fn(f,val);#makes Newton's approximation with f value
				step+=1;
				##########STEP PRINTING SECTION
				print("\n---------------STEP:%d\n" % step);
				print("%f - (%f-%f)/(2 * %f) = %.6f\n" % [f,f*f,val,f,tmp] );
				print("---------------\n");
				##########END STEP PRINT
				
				#Condition of non-repetition:
				#if the actual step and the last one, or 
				#the next with the last, have the same value,
				#this approximation could not be improved and
				#the loop must be finished or it will continue forever
				
				if(cmp(tmpL,tmp) or cmp(tmpL,fn(tmp,val)) ); then
					if(cmp(tmpL,fn(tmp,val))); then
					#if last and next estimations are equal, it implies
					#it will be repeated infinitely between this value
					#and the next [apparently, it happens when the 
					#precision of calculations are in their limit];
					#so, I choose the average of this and last values
					#to answer this question.
						tmpL=(tmpL+tmp)/2.0;
					end;
					break;
				end;
				f=tmp;
			end;
			#Conclusion for this value
			print("*"*40);
			print((" Comparing √(%f)=\n="+fmt(6)+" with ruby square root=\n="+fmt(6)+"\n") % [val,tmpL,(val ** 0.5)]);
			if(cmp(tmpL,(val ** 0.5))); then
				print("They are equals");
			else;
				print("They are similiar");
			end;
			print("\n");
			print("*"*40);
			print("\n");
		end;
		
	end;
	print("\n\nThanks for checking this out!\n\n");
	return(0);
end;


if caller.length==0 then	#if this is a main file (you are running, not including this)
	main();					#executing main function.
end;

"""
OUTPUT
======
-------------------

f(x)=x² - S

 a_n+1 = a_n - (a_n² - S)/(2*a_n) 

Value of S to find it's square root? (0 to exit) 
2

---------------STEP:1
1.000000 - (1.000000-2.000000)/(2 * 1.000000) = 1.500000
---------------

---------------STEP:2
1.500000 - (2.250000-2.000000)/(2 * 1.500000) = 1.416667
---------------

---------------STEP:3
1.416667 - (2.006944-2.000000)/(2 * 1.416667) = 1.414216
---------------

---------------STEP:4
1.414216 - (2.000006-2.000000)/(2 * 1.414216) = 1.414214
---------------

---------------STEP:5
1.414214 - (2.000000-2.000000)/(2 * 1.414214) = 1.414214
---------------
**************************************** Comparing √(2.000000)=
=1.414214 with ruby square root=
=1.414214
They are equals
****************************************

-------------------

f(x)=x² - S

 a_n+1 = a_n - (a_n² - S)/(2*a_n) 

Value of S to find it's square root? (0 to exit) 
436

---------------STEP:1
1.000000 - (1.000000-436.000000)/(2 * 1.000000) = 218.500000
---------------

---------------STEP:2
218.500000 - (47742.250000-436.000000)/(2 * 218.500000) = 110.247712
---------------

---------------STEP:3
110.247712 - (12154.557929-436.000000)/(2 * 110.247712) = 57.101221
---------------

---------------STEP:4
57.101221 - (3260.549456-436.000000)/(2 * 57.101221) = 32.368392
---------------

---------------STEP:5
32.368392 - (1047.712821-436.000000)/(2 * 32.368392) = 22.919161
---------------

---------------STEP:6
22.919161 - (525.287963-436.000000)/(2 * 22.919161) = 20.971273
---------------

---------------STEP:7
20.971273 - (439.794271-436.000000)/(2 * 20.971273) = 20.880809
---------------

---------------STEP:8
20.880809 - (436.008184-436.000000)/(2 * 20.880809) = 20.880613
---------------

---------------STEP:9
20.880613 - (436.000000-436.000000)/(2 * 20.880613) = 20.880613
---------------
**************************************** Comparing √(436.000000)=
=20.880613 with ruby square root=
=20.880613
They are equals
****************************************

-------------------

f(x)=x² - S

 a_n+1 = a_n - (a_n² - S)/(2*a_n) 

Value of S to find it's square root? (0 to exit) 
0


Thanks for checking this out!



"""
