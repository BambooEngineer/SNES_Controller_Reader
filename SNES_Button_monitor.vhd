library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity SNES_Button_monitor is
generic ( 
	N: Integer := 16 -- number of buttons
); -- 9 sets of 4 bits to make a gamecube byte + 1x stop signal
port (
   data: in std_logic; 
	clk: in std_logic;	-- 20uS snes controller bit banging speed instead of 12uS normal
   Cout: out std_logic; 
   latch: out std_logic;
	LEDs : out std_logic_vector(N-1 downto 0)
  );
end SNES_Button_monitor;

architecture serializer of SNES_Button_monitor is 

	signal buttons: std_logic_vector(N-1 DOWNTO 0); --0x40 with a stop bit on the end ********* ( add rest of the needed bits then make another vhdl block trigger this one to stop or make a counter on here then test gcc response ) 
	--signal latch_debounce: std_logic:= '0';
	--signal latch_debounce: std_logic := '0';
	--signal din : std_logic := '1';
	
	
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
	
	--latch <= latch_debounce;
	Cout <= not clk;
	LEDs <= buttons;
		
			
		

	--process(clk)
		--variable count: integer range 0 to N+1 := 0;
	--begin 
		--if(clk'EVENT and clk='1') THEN -- get rid of stop code to get back to working state 
		--	count := count + 1;
		--	if(count>=N) then
		--		count := 0;
		--	end if;
		--dout <= internal(count);
	--	end if;
	--end process; 
	
	
	
	
	
	
	
	
	
	
	
end architecture;