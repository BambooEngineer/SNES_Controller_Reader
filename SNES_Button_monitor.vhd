library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity SNES_Button_monitor is
generic ( 
	N: Integer := 16 -- number of buttons
); 
port (
   data: in std_logic; 
	clk: in std_logic;	
   Cout: out std_logic; 
   latch: out std_logic;
	LEDs : out std_logic_vector(N-1 downto 0)
  );
end SNES_Button_monitor;

architecture serializer of SNES_Button_monitor is 

	signal buttons: std_logic_vector(N-1 DOWNTO 0); 
	
	
	
begin

	process(clk) 
		variable count : integer range 0 to N;
	begin
		if(clk'event and clk='1') then
		   latch <= '0';
			count := count + 1;
			if(count >= N) then
				count := 0;
				latch <= '1';
			end if;
			buttons(count) <= data;
		end if; 
	end process;
	
	
	Cout <= not clk;
	LEDs <= buttons;
		
			
		

	
	
	
	
	
	
	
	
	
	
	
	
end architecture;
