--------------------------------
-- Components for C Processor --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --	
--------------------------------


--------------------------------
-- D-FF                       --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2005/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity MY_DFF is
  port (
    d   : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic;
    qb  : out std_logic
  );
end MY_DFF;

architecture logic of MY_DFF is
begin 
  MY_DFF : process (clk)
  begin
    if clk'event and clk = '1' then
      if( rst = '1' ) then
        q <= '0';
      else  
        q  <= d;
        qb <= not d;
      end if;
    end if;
  end process MY_DFF;
end logic;


--------------------------------
-- 1 bit Register             --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--    Modify Keishi SAKANUSHI --
--                 2005/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Register01 is
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end Register01;

architecture logic of Register01 is

signal Dtmp : std_logic;
signal Qtmp : std_logic;

component MY_DFF
  port (
    d   : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic;
    qb  : out std_logic
  );
end component;

begin 
  dff1 : MY_DFF
  port map (
    d => Dtmp,
    clk => clock,
    rst => reset,
    q => Qtmp
  );
  Dtmp <= ( Qtmp and not load ) or ( d and load );
  q <= Qtmp;
end logic;



--------------------------------
-- 8 bit Register             --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--    Modify Keishi SAKANUSHI --
--                 2005/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Register08 is
  port (
    d     : in  std_logic_vector(7 downto 0);
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(7 downto 0)
  );
end Register08;

architecture logic of Register08 is

signal Dtmp : std_logic_vector(7 downto 0);
signal Qtmp : std_logic_vector(7 downto 0);

component MY_DFF
  port (
    d   : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic;
    qb  : out std_logic
  );
end component;


begin 
  Generate_Registers : for i in 0 to 7 generate
  dffi : MY_DFF
  port map (
    d => Dtmp(i),
    clk => clock,
    rst => reset,
    q => Qtmp(i)
  );
  Dtmp(i) <= (Qtmp(i) and not load) or ( d(i) and load );
  q(i) <= Qtmp(i);
  end generate Generate_Registers;
end logic;

--------------------------------
-- 16 bit Register            --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--    Modify Keishi SAKANUSHI --
--                 2005/08/23 --
--------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity Register16 is
  port (
    d     : in  std_logic_vector(15 downto 0);
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(15 downto 0)
  );
end Register16;

architecture logic of Register16 is
signal Dtmp : std_logic_vector(15 downto 0);
signal Qtmp : std_logic_vector(15 downto 0);

component MY_DFF
  port (
    d   : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic;
    qb  : out std_logic
  );
end component;


begin 
  Generate_Registers : for i in 0 to 15 generate
  dffi : MY_DFF
  port map (
    d => Dtmp(i),
    clk => clock,
    rst => reset,
    q => Qtmp(i)
  );
  Dtmp(i) <= (Qtmp(i) and not load) or ( d(i) and load );
  q(i) <= Qtmp(i);
  end generate Generate_Registers;
end logic;


--------------------------------
-- 16 bit (in 2) Register     --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity Register16in2 is
  port (
    dh    : in  std_logic_vector(7 downto 0);
    dl    : in  std_logic_vector(7 downto 0);
    loadh : in  std_logic;
    loadl : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(15 downto 0)
  );
end Register16in2;

architecture logic of Register16in2 is

component Register08
  port (
    d     : in  std_logic_vector(7 downto 0);
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(7 downto 0)
  );
end component;

begin
  RegH : Register08
  port map(
    d => dh,
    load => loadh,
    clock => clock,
    reset => reset,
    q => q(15 downto 8)
  );
  RegL : Register08
  port map(
    d => dl,
    load => loadl,
    clock => clock,
    reset => reset,
    q => q(7 downto 0)
  );
end logic;



--------------------------------
-- 8bit Multiplexer in 2      --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Mux2x08 is
  port (
    a   : in  std_logic_vector(7 downto 0); 
    b   : in  std_logic_vector(7 downto 0);
    sel : in  std_logic;
    q   : out std_logic_vector(7 downto 0)
  ); 
end Mux2x08;

architecture logic of Mux2x08 is
begin
  q <= a when sel = '0' else
       b ;
end logic;



--------------------------------
-- 16bit Multiplexer in 2     --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Mux2x16 is
  port (
    a   : in  std_logic_vector(15 downto 0);
    b   : in  std_logic_vector(15 downto 0);
    sel : in  std_logic;
    q   : out std_logic_vector(15 downto 0)
  );
end Mux2x16;

architecture logic of Mux2x16 is
begin
  q <= a when sel = '0' else
       b ;
end logic;


--------------------------------
-- Full Adder                 --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
  port (
    x     : in  std_logic;
    y     : in  std_logic;
    cin   : in  std_logic;
    s     : out std_logic;
    c     : out std_logic
  );
end FullAdder;

architecture rtl of FullAdder is
begin 
  s <= x xor y xor cin;
  c <= (x and y) or ((x or y) and cin);
end rtl;



--------------------------------
-- 8 bit Ripple Carry Adder   --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity RCAdder08 is
  port (
    x     : in  std_logic_vector(7 downto 0);
    y     : in  std_logic_vector(7 downto 0);
    cin   : in  std_logic;
    s     : out std_logic_vector(7 downto 0);
    c     : out std_logic
  );
end RCAdder08;

architecture rtl of RCAdder08 is
component FullAdder
  port (
    x     : in  std_logic;
    y     : in  std_logic;
    cin   : in  std_logic;
    s     : out std_logic;
    c     : out std_logic
  );
end component;
signal carry : std_logic_vector(8 downto 0);
begin
  carry(0) <= cin;
  add_gen: for i in 0 to 7 generate
    adderi : FullAdder
      port map (
        x => x(i),
        y => y(i),
        cin => carry(i),
        s => s(i),
        c => carry(i+1)
      );
    end generate add_gen; 
  c <= carry(8);
end rtl;



--------------------------------
-- 16 bit Ripple Carry Adder  --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity RCAdder16 is
  port (
    x     : in  std_logic_vector(15 downto 0);
    y     : in  std_logic_vector(15 downto 0);
    cin   : in  std_logic;
    s     : out std_logic_vector(15 downto 0);
    c     : out std_logic
  );
end RCAdder16;

architecture rtl of RCAdder16 is
component FullAdder
  port (
    x     : in  std_logic;
    y     : in  std_logic;
    cin   : in  std_logic;
    s     : out std_logic;
    c     : out std_logic
  );
end component;
signal carry : std_logic_vector(16 downto 0);
begin
  carry(0) <= cin;
  adder_generate: for i in 0 to 15 generate
    adderi : FullAdder
      port map (
        x => x(i),
        y => y(i),
        cin => carry(i),
        s => s(i),
        c => carry(i+1)
      );
    end generate adder_generate; 
  c <= carry(16);
end rtl;



--------------------------------
--                            --
-- 8 bit ALU                  --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--                            --
--------------------------------

--------------------------------
--                            --
-- mode                       --
--                            --
-- '00' : not a               --
-- '01' : a + b               --
-- '10' : a + 1               --
-- '11' : a - 1               --
--                            --
--------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

entity ALU08 is
  port (
    a       : in  std_logic_vector(7 downto 0);
    b       : in  std_logic_vector(7 downto 0);
    cin     : in  std_logic;
    mode    : in  std_logic_vector(3 downto 0);
    fout    : out std_logic_vector(7 downto 0);
    cout    : out std_logic;
    zout    : out std_logic
  );
end ALU08;

architecture logic of ALU08 is
component RCAdder08
  port (
    x     : in  std_logic_vector(7 downto 0);
    y     : in  std_logic_vector(7 downto 0);
    cin   : in  std_logic;
    s     : out std_logic_vector(7 downto 0);
    c     : out std_logic
  );
end component;
component Multiple
  port (
    x     : in  std_logic_vector(7 downto 0);
    y     : in  std_logic_vector(7 downto 0);
    s     : out std_logic_vector(7 downto 0);
    c     : out std_logic
  );
end component;
signal result       : std_logic_vector(7 downto 0);
signal result_adder : std_logic_vector(7 downto 0);
signal result_multple : std_logic_vector(7 downto 0);
signal result_logic : std_logic_vector(7 downto 0);
signal inA          : std_logic_vector(7 downto 0);
signal inB          : std_logic_vector(7 downto 0);
signal cout_tmp     : std_logic;
signal cout_mult    : std_logic;
signal cin_tmp      : std_logic;


begin

inA <= a         when mode = "0000"    -- (a + b)
	              else 
 		     a when mode = "0100"    -- (not a )
	              else 
		     a when mode = "1000"    -- (not b )
	              else
		     a when mode = "0001"    -- (a-b )
	              else 
		     a when mode = "0101"    -- (a+1 )
	              else
		     "00000001" when mode = "1001"    -- (b+1 )
	              else
		     a when mode = "0010"    -- (a and b )
	              else
		     a when mode = "0110"    -- (a-1 )
	              else
 		     "11111111" when mode = "1010"    -- (b-1 )
	              else
	             a when mode = "0110"    -- (a or b )
	              else
                     a;



 
inB <= b         when mode = "0000"    -- (a + b)
	              else 
 		     b when mode = "0100"    -- (not a )
	              else 
		     b when mode = "1000"    -- (not b )
	              else
		     b xor "11111111" when mode = "0001"    -- (a-b )
	              else 
		     "00000001" when mode = "0101"    -- (a+1 )
	              else
		     b           when mode = "1001"    -- (b+1 )
	              else
		     b when mode = "0010"    -- (a and b )
	              else
		     "11111111" when mode = "0110"    -- (a-1 )
	              else
 		     b when mode = "0110"    -- (b-1 )
	              else
	             b when mode = "0110"    -- (a or b )
	              else
                     b;
cin_tmp <='1' when mode ="0001"
              else
              cin;

adder : RCAdder08
  port map (
    x   => inA,
    y   => inB,
    cin => cin_tmp,
    s   => result_adder,
    c   => cout_tmp
  );
 mult : Multiple
  port map (
    x   => inA,
    y   => inB,
    s   => result_multple,
    c   => cout_mult
  );
zout <= '1' when (result = "00000000")
            else
        '0';

cout <= cout_mult when mode="0111"
                  else
        cout_mult when mode="1011"
                  else
        cout_tmp;
               


result_logic <= (not a)   when mode = "0100" -- ( not a )
                          else
		(not b)   when mode = "1000" -- ( not a )
                          else
		(a and b)   when mode = "0010" -- ( not a )
                          else
		(a or b)   when mode = "0011" -- ( not a )
                          else

                "00000000";


result <= result_adder when mode = "0000" or -- (a + b)
                            mode = "0001" or -- (a + 1)
                            mode = "0101"or    -- (a - 1)
 			    mode = "1001"or    -- (a - 1)
			    mode = "0110"or    -- (a - 1)
                            mode = "1010"      -- (a - 1)
                       else
          result_multple when mode = "0111" or -- MULA
                              mode = "1011"  -- MULB
                       else
          result_logic;
                  
fout <= result;
                    
end logic;


--------------------------------
-- 16 bit Counter             --
--                            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;

entity Counter16 is
  port (
    clock : in  std_logic;
    load  : in  std_logic;
    d     : in  std_logic_vector(15 downto 0);
    inc   : in  std_logic;
    inc2  : in  std_logic;
    clear : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(15 downto 0)
  );
end Counter16;

architecture logic of Counter16 is
component RCAdder16
  port (
    x     : in  std_logic_vector(15 downto 0);
    y     : in  std_logic_vector(15 downto 0);
    cin   : in  std_logic;
    s     : out std_logic_vector(15 downto 0);
    c     : out std_logic
  );
end component;

component Register16
  port (
    d     : in  std_logic_vector(15 downto 0);
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(15 downto 0)
  );
end component;

signal data           : std_logic_vector(15 downto 0);
signal zero           : std_logic;
signal load_in        : std_logic;
signal add_result     : std_logic_vector(15 downto 0);
signal data_in        : std_logic_vector(15 downto 0);
signal result         : std_logic_vector(15 downto 0);
signal carry          : std_logic;

begin 
  reg : register16
    port map (
      d     => data_in,
      load  => load_in,
      clock => clock,
      reset => reset,
      q     => result
    );

  q <= result;

  data_in <= d          when load = '1' else
             add_result when inc = '1' or inc2 = '1' else
             "0000000000000000";

  load_in <= '1' when load = '1' or inc = '1' or clear = '1'
                      or inc2 = '1' else
             '0';

  adder : RCAdder16
    port map (
      x    => result,
      y    => data,
      cin  => zero,
      s    => add_result,
      c    => carry
      );

  data <= "0000000000000001" when inc = '1' else
          "0000000000000010";
  
  zero <= '0';
end logic;


--------------------------------
-- 1bit Johnson Counter       --
--      Loop S0               --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson1L0 is
  port (
    cond0 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end Johnson1L0;

architecture logic of Johnson1L0 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end component;

signal result : std_logic;
signal stop1  : std_logic;
signal one    : std_logic;

begin 
one <= '1';

stop1 <= not result and cond0;

jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result
  );

q <= result;

end logic;


--------------------------------
-- 1bit Johnson Counter       --
--      Loop S1               --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson1L1 is
  port (
    cond1 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end Johnson1L1;

architecture logic of Johnson1L1 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end component;

signal result : std_logic;
signal stop1  : std_logic;
signal one    : std_logic;

begin
one <= '1';
stop1 <= (result and not cond1) or not result ;

jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result
  );

q <= result;

end logic;



--------------------------------
-- 1bit Johnson Counter       --
--      Loop S0 S1            --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson1L01 is
  port (
    cond0 : in  std_logic;
    cond1 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end Johnson1L01;

architecture logic of Johnson1L01 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end component;

signal result : std_logic;
signal stop1  : std_logic;
signal one    : std_logic;

begin

one <= '1';
jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result
  );

q <= result;

stop1 <= (not result and cond0) or ( result and not cond1);

end logic;



--------------------------------
-- 2bit Johnson Counter       --
--      Loop S0               --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson2L0 is
  port (
    cond0 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
  );
end Johnson2L0;

architecture logic of Johnson2L0 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end component;

signal result : std_logic_vector(1 downto 0);
signal stop1  : std_logic;
signal one    : std_logic;

begin
one <= '1';

jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(0)
  );

jc2 : Register01
  port map(
  d     => result(0),
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(1)
  );

q <= result;

stop1 <= not result(1) and ( result(0) or cond0);

end logic;



--------------------------------
-- 3bit Johnson Counter       --
--      Loop S0               --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson3L0 is
  port (
    cond0 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(2 downto 0)
  );
end Johnson3L0;

architecture logic of Johnson3L0 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
      );
end component;

signal result : std_logic_vector(2 downto 0);
signal stop1  : std_logic;
signal one    : std_logic;

begin

one <= '1';
stop1 <= ( result(0) or cond0 ) and not result(2) ;

jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(0)
  );

jc2 : Register01
  port map(
  d     => result(0),
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(1)
  );

jc3 : Register01
  port map(
  d     => result(1),
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(2)
  );
q <= result;

end logic;
--------------------------------
-- MuX04       --
--      Loop S0               --
--       (c) Keishi SAKANUSHI --
--                 2004/08/23 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Mux4x08 is
  port (
    a   : in  std_logic_vector(7 downto 0); 
    b   : in  std_logic_vector(7 downto 0);
    c   : in  std_logic_vector(7 downto 0); 
    d   : in  std_logic_vector(7 downto 0); 
    sel : in  std_logic_vector(1 downto 0);
    q   : out std_logic_vector(7 downto 0)
  ); 
end Mux4x08;

architecture logic of Mux4x08 is
begin
  q <= a when sel = "00" else
       b when sel = "01" else
       c when sel = "10" else
d;
end logic;
--------------------------------
--Multiple        --
--      Loop S0               --
--       (c) Yoshizaki hibiki --
--                 2022/12/05 --
--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Multiple is
  port (
    x     : in  std_logic_vector(7 downto 0);
    y     : in  std_logic_vector(7 downto 0);
    s     : out std_logic_vector(7 downto 0);
    c     : out std_logic
  ); 
end Multiple;

architecture logic of Multiple is
component RCAdder08
  port (
    x     : in  std_logic_vector(7 downto 0);
    y     : in  std_logic_vector(7 downto 0);
    cin   : in  std_logic;
    s     : out std_logic_vector(7 downto 0);
    c     : out std_logic
  );
end component;
component RCAdder16

  port (
    x     : in  std_logic_vector(15 downto 0);
    y     : in  std_logic_vector(15 downto 0);
    cin   : in  std_logic;
    s     : out std_logic_vector(15 downto 0);
    c     : out std_logic
  );
end component;

signal result       : std_logic_vector(7 downto 0);
signal box	    : std_logic_vector(7 downto 0);
signal box1	    : std_logic_vector(7 downto 0);
signal box2	    : std_logic_vector(7 downto 0);
signal box3	    : std_logic_vector(7 downto 0);
signal answer	    : std_logic_vector(7 downto 0);
signal answer1	    : std_logic_vector(7 downto 0);
signal answer2	    : std_logic_vector(7 downto 0);
signal answer3	    : std_logic_vector(7 downto 0);
signal answer4	    : std_logic_vector(7 downto 0);
signal answer5	    : std_logic_vector(7 downto 0);
signal largeanswer    : std_logic_vector(15 downto 0);
signal largeanswer1    : std_logic_vector(15 downto 0);
signal largeanswer2    : std_logic_vector(15 downto 0);
signal largeanswer3    : std_logic_vector(15 downto 0);
signal largeanswer4    : std_logic_vector(15 downto 0);
signal largeboxA    : std_logic_vector(15 downto 0);
signal largeboxA1    : std_logic_vector(15 downto 0);
signal largeboxA2    : std_logic_vector(15 downto 0);
signal largeboxA3    : std_logic_vector(15 downto 0);
signal largeboxA4    : std_logic_vector(15 downto 0);
signal largeboxB    : std_logic_vector(15 downto 0);
signal largeboxB1    : std_logic_vector(15 downto 0);
signal largeboxB2    : std_logic_vector(15 downto 0);
signal largeboxB3   : std_logic_vector(15 downto 0);
signal largeboxB4    : std_logic_vector(15 downto 0);
signal result_adder : std_logic_vector(7 downto 0);
signal result_logic : std_logic_vector(7 downto 0);
signal inE1          : std_logic_vector(7 downto 0);
signal inE2          : std_logic_vector(7 downto 0);
signal inE3          : std_logic_vector(7 downto 0);
signal inE4          : std_logic_vector(7 downto 0);
signal inE5          : std_logic_vector(7 downto 0);
signal inE6          : std_logic_vector(7 downto 0);
signal inE7          : std_logic_vector(7 downto 0);
signal inE8          : std_logic_vector(7 downto 0);
signal inA1          : std_logic_vector(7 downto 0);
signal inA2          : std_logic_vector(9 downto 0);
signal inA3          : std_logic_vector(7 downto 0);
signal inA4          : std_logic_vector(9 downto 0);
signal inB1          : std_logic_vector(7 downto 0);
signal inB2          : std_logic_vector(11 downto 0);
signal inC1          : std_logic_vector(7 downto 0);

signal y0             : std_logic_vector(7 downto 0);
signal y1             : std_logic_vector(7 downto 0);
signal y2             : std_logic_vector(7 downto 0);
signal y3             : std_logic_vector(7 downto 0);
signal y4             : std_logic_vector(7 downto 0);
signal y5             : std_logic_vector(7 downto 0);
signal y6             : std_logic_vector(7 downto 0);
signal y7             : std_logic_vector(7 downto 0);
signal cout_tmp     : std_logic;
signal cout_tmp1     : std_logic;
signal cout_tmp2    : std_logic;
signal cout_tmp3     : std_logic;
signal cout_tmp4     : std_logic;
signal cout_tmp5     : std_logic;
signal cout_tmp6    : std_logic;
signal cout_tmp7     : std_logic;
signal cin_tmp      : std_logic;
signal amari        : std_logic;
signal car          : std_logic;

begin
y0 <=y(0)&y(0)&y(0)&y(0)&y(0)&y(0)&y(0)&y(0);
y1 <=y(1)&y(1)&y(1)&y(1)&y(1)&y(1)&y(1)&y(1);
y2 <=y(2)&y(2)&y(2)&y(2)&y(2)&y(2)&y(2)&y(2);
y3 <=y(3)&y(3)&y(3)&y(3)&y(3)&y(3)&y(3)&y(3);
y4 <=y(4)&y(4)&y(4)&y(4)&y(4)&y(4)&y(4)&y(4);
y5 <=y(5)&y(5)&y(5)&y(5)&y(5)&y(5)&y(5)&y(5);
y6 <=y(6)&y(6)&y(6)&y(6)&y(6)&y(6)&y(6)&y(6);
y7 <=y(7)&y(7)&y(7)&y(7)&y(7)&y(7)&y(7)&y(7);

inE1 <=y0 and x;
inE2 <=y1 and x;
inE3 <=y2 and x;
inE4 <=y3 and x;
inE5 <=y4 and x;
inE6 <=y5 and x;
inE7 <=y6 and x;
inE8 <=y7 and x;

s(0) <= inE1(0);
box <= '0' & inE1(7 downto 1);
cin_tmp <='0';
adder1 : RCAdder08
  port map (
    x   => box,
    y   => inE2,
    cin => cin_tmp,
    s   => answer,
    c   => cout_tmp
  );
inA1 <= cout_tmp & answer(7 downto 1);
s(1) <= answer(0);
box1 <= '0' & inE3(7 downto 1);
adder2 : RCAdder08
  port map (
    x   => box1,
    y   => inE4,
    cin => cin_tmp,
    s   => answer1,
    c   => cout_tmp1
  );
inA2 <= cout_tmp1 & answer1 & inE3(0);
box2 <= '0' & inE5(7 downto 1);
adder3 : RCAdder08
  port map (
    x   => box2,
    y   => inE6,
    cin => cin_tmp,
    s   => answer2,
    c   => cout_tmp2
  );
amari <= answer2(0);
inA3 <= cout_tmp2 & answer2(7 downto 1);
box3 <= '0' & inE7(7 downto 1);
adder4 : RCAdder08
  port map (
    x   => box3,
    y   => inE8,
    cin => cin_tmp,
    s   => answer3,
    c   => cout_tmp3
  );
inA4 <= cout_tmp3 & answer3 & inE7(0);
largeboxA <="00000000" & inA1;
largeboxB <="000000" & inA2;
adder5 : RCAdder16
  port map (
    x   => largeboxA,
    y   => largeboxB,
    cin => cin_tmp,
    s   => largeanswer,
    c   => cout_tmp4
  );
s(2) <= largeanswer(0);
s(3) <= largeanswer(1);
inB1 <= largeanswer(9 downto 2);
largeboxA1 <= "00000000" & inA3;
largeboxB1 <= "000000" & inA4;
adder6 : RCAdder16
  port map (
    x   => largeboxA1,
    y   => largeboxB1,
    cin => cin_tmp,
    s   => largeanswer1,
    c   => cout_tmp5
  );
inB2 <= largeanswer1(9 downto 0) & amari &inE5(0);
largeboxA2 <= "00000000" & inB1 ;
largeboxB2 <= "0000" & inB2 ;
adder7 : RCAdder16
  port map (
    x   => largeboxA2,
    y   => largeboxB2,
    cin => cin_tmp,
    s   => largeanswer2,
    c   => cout_tmp6
  );
s(4) <= largeanswer2(0);
s(5) <= largeanswer2(1);
s(6) <= largeanswer2(2);
s(7) <= largeanswer2(3);

car <= largeanswer2(4) or largeanswer2(5) or largeanswer2(6) or largeanswer2(7) or largeanswer2(8) or largeanswer2(9) or largeanswer2(10) or largeanswer2(11);
c <= '1'         when car ='1'    
	              else 
                      '0';
end logic;