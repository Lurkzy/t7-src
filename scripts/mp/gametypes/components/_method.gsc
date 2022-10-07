#namespace _method;

function save_player_location(print = false)
{
    self.pers["saved_position"] = self.origin;
    self.pers["saved_angles"] = self getplayerangles();

    if(print)
        self iprintln("Position ^5Saved^7");
}

function load_player_location(print = false)
{
    if(!isdefined(self.pers["saved_position"]))
        self iprintln("Please Save a position first!");
        
    self.origin = self.pers["saved_position"];
    self.angles = self.pers["saved_angles"];

    if(print)
        self iprintln("Position ^5Loaded^7");
}

function load_player_location_on_spawn()
{
    if(!isdefined(self.pers["load_position_on_spawn"]))
    {
        self.pers["load_position_on_spawn"] = true;
        self iprintln("Load Position on Spawn: ^5Enabled^7");
    }
    if(!self.pers["load_position_on_spawn"])
    {
        self.pers["load_position_on_spawn"] = true;
        self iprintln("Load Position on Spawn: ^5Enabled^7");
    }
    else 
    {
        self.pers["load_position_on_spawn"] = false;
        self iprintln("Load Position on Spawn: ^5Disabled^7");
    }
}