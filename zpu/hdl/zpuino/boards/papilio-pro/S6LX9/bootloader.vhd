library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use ieee.numeric_std.all;

entity bootloader_dp_32 is
  port (
    CLK:              in std_logic;
    WEA:  in std_logic;
    ENA:  in std_logic;
    MASKA:    in std_logic_vector(3 downto 0);
    ADDRA:         in std_logic_vector(11 downto 2);
    DIA:        in std_logic_vector(31 downto 0);
    DOA:         out std_logic_vector(31 downto 0);
    WEB:  in std_logic;
    ENB:  in std_logic;
    ADDRB:         in std_logic_vector(11 downto 2);
    DIB:        in std_logic_vector(31 downto 0);
    MASKB:    in std_logic_vector(3 downto 0);
    DOB:         out std_logic_vector(31 downto 0)
  );
end entity bootloader_dp_32;

architecture behave of bootloader_dp_32 is

  subtype RAM_WORD is STD_LOGIC_VECTOR (31 downto 0);
  type RAM_TABLE is array (0 to 1023) of RAM_WORD;
 shared variable RAM: RAM_TABLE := RAM_TABLE'(
x"0b0b0b98",x"a9040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b98",x"8a040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fd0608",x"72830609",x"81058205",x"832b2a83",x"ffff0652",x"04000000",x"00000000",x"00000000",x"71fd0608",x"83ffff73",x"83060981",x"05820583",x"2b2b0906",x"7383ffff",x"0b0b0b0b",x"83a70400",x"72098105",x"72057373",x"09060906",x"73097306",x"070a8106",x"53510400",x"00000000",x"00000000",x"72722473",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71737109",x"71068106",x"30720a10",x"0a720a10",x"0a31050a",x"81065151",x"53510400",x"00000000",x"72722673",x"732e0753",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"cc040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"720a722b",x"0a535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72729f06",x"0981050b",x"0b0b88af",x"05040000",x"00000000",x"00000000",x"00000000",x"00000000",x"72722aff",x"739f062a",x"0974090a",x"8106ff05",x"06075351",x"04000000",x"00000000",x"00000000",x"71715351",x"020d0406",x"73830609",x"81058205",x"832b0b2b",x"0772fc06",x"0c515104",x"00000000",x"72098105",x"72050970",x"81050906",x"0a810653",x"51040000",x"00000000",x"00000000",x"00000000",x"72098105",x"72050970",x"81050906",x"0a098106",x"53510400",x"00000000",x"00000000",x"00000000",x"71098105",x"52040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72720981",x"05055351",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097206",x"73730906",x"07535104",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71fc0608",x"72830609",x"81058305",x"1010102a",x"81ff0652",x"04000000",x"00000000",x"00000000",x"71fc0608",x"0b0b0b9a",x"f0738306",x"10100508",x"060b0b0b",x"88b20400",x"00000000",x"00000000",x"0b0b0b89",x"80040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"0b0b0b88",x"e8040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"72097081",x"0509060a",x"8106ff05",x"70547106",x"73097274",x"05ff0506",x"07515151",x"04000000",x"72097081",x"0509060a",x"098106ff",x"05705471",x"06730972",x"7405ff05",x"06075151",x"51040000",x"05ff0504",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"810b0b0b",x"0b9be80c",x"51040000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"71810552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"02840572",x"10100552",x"04000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"717105ff",x"05715351",x"020d0400",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"81dd3f92",x"c13f0400",x"00000000",x"00000000",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101010",x"10101053",x"51047381",x"ff067383",x"06098105",x"83051010",x"102b0772",x"fc060c51",x"51043c04",x"72728072",x"8106ff05",x"09720605",x"71105272",x"0a100a53",x"72ed3851",x"51535104",x"88088c08",x"90087575",x"99b12d50",x"50880856",x"900c8c0c",x"880c5104",x"88088c08",x"90087575",x"98ed2d50",x"50880856",x"900c8c0c",x"880c5104",x"88088c08",x"90088ebb",x"2d900c8c",x"0c880c04",x"ff3d0d0b",x"0b0b9bf8",x"335170a6",x"389bf408",x"70085252",x"70802e92",x"3884129b",x"f40c702d",x"9bf40870",x"08525270",x"f038810b",x"0b0b0b9b",x"f834833d",x"0d040480",x"3d0d0b0b",x"0b9ca408",x"802e8e38",x"0b0b0b0b",x"800b802e",x"09810685",x"38823d0d",x"040b0b0b",x"9ca4510b",x"0b0bf5f8",x"3f823d0d",x"0404ff3d",x"0d80c480",x"80845271",x"0870822a",x"70810651",x"515170f3",x"38833d0d",x"04ff3d0d",x"80c48080",x"84527108",x"70812a70",x"81065151",x"5170f338",x"7382900a",x"0c833d0d",x"04fd3d0d",x"75547333",x"7081ff06",x"53537180",x"2e8e3872",x"81ff0651",x"8aa92d81",x"1454e739",x"853d0d04",x"fe3d0d74",x"7080dc80",x"80880c70",x"81ff06ff",x"83115451",x"53718126",x"8d3880fd",x"518aa92d",x"72a03251",x"83397251",x"8aa92d84",x"3d0d0480",x"3d0d83ff",x"ff0b83d0",x"0a0c80fe",x"518aa92d",x"823d0d04",x"ff3d0d83",x"d00a0870",x"882a5252",x"8aec2d71",x"81ff0651",x"8aec2d80",x"fe518aa9",x"2d833d0d",x"0482f6ff",x"0b80cc80",x"80880c80",x"0b80cc80",x"80840c9f",x"0b83900a",x"0c04ff3d",x"0d737008",x"515180c8",x"80808470",x"08708480",x"8007720c",x"5252833d",x"0d04ff3d",x"0d80c880",x"80847008",x"70fbffff",x"06720c52",x"52833d0d",x"04a0900b",x"a0800c9b",x"fc0ba084",x"0c98c22d",x"ff3d0d73",x"518b710c",x"90115298",x"8080720c",x"80720c70",x"0883ffff",x"06880c83",x"3d0d04fa",x"3d0d787a",x"7dff1e57",x"57585373",x"ff2ea738",x"80568452",x"75730c72",x"0888180c",x"ff125271",x"f3387484",x"16740872",x"0cff1656",x"565273ff",x"2e098106",x"dd38883d",x"0d04f83d",x"0d80c080",x"80845783",x"d00a0b9b",x"b852598a",x"c92d8c86",x"2d76518c",x"ac2d9bfc",x"70880810",x"10988084",x"05717084",x"05530c56",x"56fb8084",x"a1ad750c",x"9ba80b88",x"170c8070",x"780c770c",x"760883ff",x"ff065683",x"ffdf800b",x"8808278f",x"389bc051",x"8ac92d9b",x"e4518ac9",x"2dff3983",x"ffff790c",x"a0805488",x"08537852",x"76518ccb",x"2d76518b",x"ea2d7808",x"5574762e",x"893880c3",x"518aa92d",x"ff39a084",x"085574fa",x"a090ae80",x"2e893880",x"c2518aa9",x"2dff399b",x"c4518ac9",x"2d900a70",x"0870ffbf",x"06720c56",x"568a8e2d",x"8c9d2dff",x"3d0d9c88",x"0881119c",x"880c5183",x"900a7008",x"70feff06",x"720c5252",x"833d0d04",x"803d0d8b",x"9b2d7281",x"8007518a",x"ec2d8bb0",x"2d823d0d",x"04fe3d0d",x"80c08080",x"84538c86",x"2d85730c",x"80730c72",x"087081ff",x"06745351",x"528bea2d",x"71880c84",x"3d0d04fc",x"3d0d7681",x"11338212",x"33718180",x"0a297184",x"80802905",x"83143370",x"82802912",x"84163352",x"7105a080",x"05861685",x"17335752",x"53535557",x"5553ff13",x"5372ff2e",x"91387370",x"81055533",x"52717570",x"81055734",x"e9398951",x"8ed82d86",x"3d0d04f9",x"3d0d7957",x"80c08080",x"84568c86",x"2d811733",x"82183371",x"82802905",x"53537180",x"2e943885",x"17725553",x"72708105",x"5433760c",x"ff145473",x"f3388317",x"33841833",x"71828029",x"05565280",x"54737527",x"97387358",x"77760c73",x"17760853",x"53717334",x"81145474",x"7426ed38",x"75518bea",x"2d8b9b2d",x"8184518a",x"ec2d7488",x"2a518aec",x"2d74518a",x"ec2d8054",x"7375278f",x"38731770",x"3352528a",x"ec2d8114",x"54ee398b",x"b02d893d",x"0d04f93d",x"0d795680",x"c0808084",x"558c862d",x"86750c74",x"518bea2d",x"8c862d81",x"ad70760c",x"81173382",x"18337182",x"80290583",x"1933780c",x"84193378",x"0c851933",x"780c5953",x"53805473",x"7727b338",x"72587380",x"2e87388c",x"862d7775",x"0c731686",x"1133760c",x"87113376",x"0c527451",x"8bea2d8e",x"ed2d8808",x"81065271",x"f6388214",x"54767426",x"d1388c86",x"2d84750c",x"74518bea",x"2d8b9b2d",x"8187518a",x"ec2d8bb0",x"2d893d0d",x"04fc3d0d",x"76811133",x"82123371",x"902b7188",x"2b078314",x"33707207",x"882b8416",x"33710751",x"52535757",x"54528851",x"8ed82d81",x"ff518aa9",x"2d80c480",x"80845372",x"0870812a",x"70810651",x"515271f3",x"38738480",x"800780c4",x"8080840c",x"863d0d04",x"fe3d0d8e",x"ed2d8808",x"88088106",x"535371f3",x"388b9b2d",x"8183518a",x"ec2d7251",x"8aec2d8b",x"b02d843d",x"0d04fe3d",x"0d800b9c",x"880c8b9b",x"2d818151",x"8aec2d9b",x"a8538f52",x"72708105",x"5433518a",x"ec2dff12",x"5271ff2e",x"098106ec",x"388bb02d",x"843d0d04",x"fe3d0d80",x"0b9c880c",x"8b9b2d81",x"82518aec",x"2d80c080",x"8084528c",x"862d81f9",x"0a0b80c0",x"80809c0c",x"71087252",x"538bea2d",x"729c900c",x"72902a51",x"8aec2d9c",x"9008882a",x"518aec2d",x"9c900851",x"8aec2d8e",x"ed2d8808",x"518aec2d",x"8bb02d84",x"3d0d0480",x"3d0d810b",x"9c8c0c80",x"0b83900a",x"0c85518e",x"d82d823d",x"0d04803d",x"0d800b9c",x"8c0c8bd1",x"2d86518e",x"d82d823d",x"0d04fd3d",x"0d80c080",x"8084548a",x"518ed82d",x"8c862d9b",x"fc745253",x"8cac2d72",x"88081010",x"98808405",x"71708405",x"530c52fb",x"8084a1ad",x"720c9ba8",x"0b88140c",x"73518bea",x"2d8a8e2d",x"8c9d2dff",x"ab3d0d80",x"0b9c8c0c",x"800b9c88",x"0c800b8e",x"bb0ba080",x"0c5780c4",x"80808455",x"8480b375",x"0c80c880",x"80a453fb",x"ffff7308",x"70720675",x"0c535480",x"c8808094",x"70087076",x"06720c53",x"53880b80",x"d0808084",x"0c80d00a",x"5381730c",x"9bdc518a",x"c92d8bd1",x"2d828888",x"0b80dc80",x"80840c81",x"f20b900a",x"0c80c080",x"80847052",x"528bea2d",x"8c862d71",x"518bea2d",x"8c862d84",x"720c7151",x"8bea2d76",x"77767593",x"3d41415b",x"5b5b83d0",x"0a5c7808",x"70810651",x"52719d38",x"9c8c0853",x"72f0389c",x"88085287",x"e87227e6",x"38727e0c",x"7283900a",x"0c98ba2d",x"82900a08",x"5379802e",x"81b43872",x"80fe2e09",x"810680f4",x"3876802e",x"c138807d",x"7858565a",x"827727ff",x"b53883ff",x"ff7c0c79",x"fe185353",x"79722798",x"3880dc80",x"80887255",x"58721570",x"33790c52",x"81135373",x"7326f238",x"ff167511",x"547505ff",x"05703374",x"33707288",x"2b077f08",x"53515551",x"5271732e",x"098106fe",x"ed387433",x"53728a26",x"fee43872",x"10109afc",x"05755270",x"08515271",x"2dfed339",x"7280fd2e",x"09810686",x"38815bfe",x"c5397682",x"9f269e38",x"7a802e87",x"388073a0",x"32545b80",x"d73d7705",x"fde00552",x"72723481",x"1757fea2",x"39805afe",x"9d397280",x"fe2e0981",x"06fe9338",x"795783ff",x"ff7c0c81",x"775c5afe",x"8539803d",x"0d88088c",x"089008a0",x"80085170",x"2d900c8c",x"0c8a0c81",x"0b80d00a",x"0c823d0d",x"04ff3d0d",x"98dd2d80",x"52805194",x"f72d833d",x"0d0483ff",x"fff80d8d",x"860483ff",x"fff80da0",x"88040000",x"00000000",x"820b80d0",x"8080900c",x"0b0b0b04",x"0098d004",x"00000000",x"00000000",x"00000000",x"00fb3d0d",x"77795555",x"80567575",x"24ab3880",x"74249d38",x"80537352",x"745180e1",x"3f880854",x"75802e85",x"38880830",x"5473880c",x"873d0d04",x"73307681",x"325754dc",x"39743055",x"81567380",x"25d238ec",x"39fa3d0d",x"787a5755",x"80577675",x"24a43875",x"9f2c5481",x"53757432",x"74315274",x"519b3f88",x"08547680",x"2e853888",x"08305473",x"880c883d",x"0d047430",x"558157d7",x"39fc3d0d",x"76785354",x"81538074",x"73265255",x"72802e98",x"3870802e",x"a9388072",x"24a43871",x"10731075",x"72265354",x"5272ea38",x"73517883",x"38745170",x"880c863d",x"0d047281",x"2a72812a",x"53537280",x"2ee63871",x"7426ef38",x"73723175",x"74077481",x"2a74812a",x"55555654",x"e539ff3d",x"0d9c980b",x"fc057008",x"525270ff",x"2e913870",x"2dfc1270",x"08525270",x"ff2e0981",x"06f13883",x"3d0d0404",x"eeba3f04",x"00ffffff",x"ff00ffff",x"ffff00ff",x"ffffff00",x"00000982",x"000009b4",x"0000095c",x"000007e7",x"00000a0b",x"00000a22",x"0000087a",x"00000909",x"00000793",x"00000a36",x"01090600",x"007fef80",x"05b8d800",x"a4041700",x"43500d0a",x"00000000",x"534c4b00",x"4c6f6164",x"65642c20",x"73746172",x"74696e67",x"2e2e2e0d",x"0a000000",x"0d0a5a50",x"55494e4f",x"0d0a0000",x"00000000",x"00000000",x"00000000",x"00000e20",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"ffffffff",x"00000000",x"ffffffff",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000");

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if ENA='1' then
        if WEA='1' then
          RAM(conv_integer(ADDRA) ) := DIA;
        end if;
        DOA <= RAM(conv_integer(ADDRA)) ;
      end if;
    end if;
  end process;  

  process (clk)
  begin
    if rising_edge(clk) then
      if ENB='1' then
        if WEB='1' then
          RAM( conv_integer(ADDRB) ) := DIB;
        end if;
        DOB <= RAM(conv_integer(ADDRB)) ;
      end if;
    end if;
  end process;  
end behave;