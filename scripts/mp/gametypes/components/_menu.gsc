#using scripts\mp\gametypes\components\_builtin;
#using scripts\mp\gametypes\components\_method;
#using scripts\mp\gametypes\components\_function;
#using scripts\mp\gametypes\components\_utils;

#using scripts\shared\lui_shared;

#namespace _menu;

function init()
{
    self.menu = spawnstruct();
    self.hud = spawnstruct();
    self.menu.isopen = false;
    self structure();
    self buttons();
    self close_on_death();
}

function buttons()
{
    self endon("disconnect");
    while(true)
    {
        if(!self.menu.isopen)
        {
            if(self getstance() == "crouch" && self adsbuttonpressed() && self meleebuttonpressed())
            {
                self.menu.isopen = true;
                self render();
                self load_menu("main");
            }
        }
        else
        {
            if(self adsbuttonpressed())
            {
                self.scroll--;
                self update_scroll();

                wait .3;
            }
            
            if(self attackbuttonpressed())
            {
                self.scroll++;
                self update_scroll();

                wait .3;
            }
            
            if(self usebuttonpressed())
            { 
                self thread [[self.menu.func[self.menu.current][self.scroll]]](self.menu.input[self.menu.current][self.scroll]);
                wait .3;
            }
            
            if(self meleebuttonpressed())
            {
                if(self.menu.parent[self.menu.current] == "exit")
                {
                    self close_menu();
                    self.menu.isopen = false;
                }
                else
                {
                    self load_menu(self.menu.parent[self.menu.current]);
                }

                wait .3;
            }
        }

        _builtin::waitserverframe();
    }
}

function render()
{
    self.hud.title = _utils::LUI_create_text("phantom", 2, int(1820 / 2) - 13, 100, (0, 0.357, 0.78));
    self.hud.menu_title = _utils::LUI_create_text("Main Menu", 0, int(1820 / 2) + 8, 125, (1, 1, 1));
    self.hud.credits = _utils::LUI_create_text("by lurkzy", 2, int(1820 / 2) - 13, 420, (1, 1, 1), 0.25);

    self.hud.background = _utils::LUI_create_rectangle( 2, int(1820 / 2), 100, 250, 350, (0, 0, 0), "white", 0.6 );
    self.hud.topbar = _utils::LUI_create_rectangle( 2, int(1820 / 2), 100, 250, 2, (0, 0.357, 0.78), "white", 0.6 );
    self.hud.topseparator = _utils::LUI_create_rectangle( 2, int(1820 / 2), 150, 250, 2, (0, 0.357, 0.78), "white", 0.6 );
    self.hud.thomasseparator = _utils::LUI_create_rectangle( 2, int(1820 / 2), 420, 250, 2, (0, 0.357, 0.78), "white", 0.6 );
    self.hud.thomasbar = _utils::LUI_create_rectangle( 2, int(1820 / 2), 449, 250, 2, (0, 0.357, 0.78), "white", 0.6 );
    self.hud.leftbar = _utils::LUI_create_rectangle( 2, int(1820 / 2), 100, 2, 350, (0, 0.357, 0.78), "white", 0.6 );
    self.hud.rightbar = _utils::LUI_create_rectangle( 2, int(1820 / 2) + 250, 100, 2, 350, (0, 0.357, 0.78), "white", 0.6 );
    
    self.hud.scrollbar = _utils::LUI_create_rectangle( 2, int(1820 / 2), 160, 250, 25, (0, 0.357, 0.78), "white", 0.6 );
}

function structure()
{
    self _utils::create_menu("main", "Main Menu", "exit");
    self _utils::add_option("main", 0, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 1, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 2, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 3, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 4, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 5, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 6, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 7, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 8, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 9, "Placeholder", &_builtin::test, "");
    self _utils::add_option("main", 10, "Placeholder", &_builtin::test, "");
}

function load_menu(menu)
{
    self.lastscroll[self.menu.current] = self.scroll;
    self delete_menu_text();
    self.menu.current = menu;

    if(!isdefined(self.lastscroll[self.menu.current]))
        self.scroll = 0;
    else
        self.scroll = self.lastscroll[self.menu.current];

    self SetLuiMenuData( self.hud.menu_title, "text", self.menu.title[self.menu.current] );
    self create_menu_text();
    self update_scroll();
}

function update_scroll()
{
    if(self.scroll < 0)
        self.scroll = self.menu.text[self.menu.current].size-1;

    if(self.scroll > self.menu.text[self.menu.current].size-1)
        self.scroll = 0;

    if(!isdefined(self.menu.text[self.menu.current][self.scroll - 5]) || self.menu.text[self.menu.current].size <= 10)
    {
        for(i = 0; i < 10; i++)
        {
            if(isdefined(self.menu.text[self.menu.current][i]))
                self SetLuiMenuData( self.hud.text[i], "text", self.menu.text[self.menu.current][i] );
            else
                self SetLuiMenuData( self.hud.text[i], "text", "" );
        }

        self SetLuiMenuData( self.hud.scrollbar, "y", 160 + (25 * self.scroll) );
    }
    else
    {
        if(isdefined(self.menu.text[self.menu.current][self.scroll + 5]))
        {
            index = 0;
            for(i = self.scroll - 5; i < self.scroll + 5; i++)
            {
                if(isdefined(self.menu.text[self.menu.current][i]))
                    self SetLuiMenuData( self.hud.text[index], "text", self.menu.text[self.menu.current][i] );
                else
                    self SetLuiMenuData( self.hud.text[index], "text", "" );

                index++;
            }

            self SetLuiMenuData( self.hud.scrollbar, "y", 160 + (25 * 5) );
        }
        else
        {
            for(i = 0; i < 10; i++)
                self SetLuiMenuData( self.hud.text[i], "text", self.menu.text[self.menu.current][self.menu.text[self.menu.current].size + (i - 10)] );

            self SetLuiMenuData( self.hud.scrollbar, "y", 160 + (25 * ((self.scroll - self.menu.text[self.menu.current].size) + 10)) );
        }
    }
}

function close_on_death()
{
    self endon(#"disconnect");
    for(;;)
    {
        self waittill("death");

        self.menu.isopen = false;
        self close_menu();
    }
}

function create_menu_text()
{
    for(i=0;i<10;i++)
    {
        self.hud.text[i] = _utils::LUI_create_text(self.menu.text[self.menu.current][i], 0, int(1820 / 2) + 8, 160 + (25 * i), (1, 1, 1));
    }
}

function delete_menu_text()
{
    for(i=0;i<self.hud.text.size;i++)
    {
        self _utils::LUI_close_menu(self.hud.text[i]);
    }
}

function close_menu()
{
    self delete_menu_text();

    self _utils::LUI_close_menu(self.hud.title);
    self _utils::LUI_close_menu(self.hud.menu_title);
    self _utils::LUI_close_menu(self.hud.credits);
    self _utils::LUI_close_menu(self.hud.background);
    self _utils::LUI_close_menu(self.hud.topbar);
    self _utils::LUI_close_menu(self.hud.topseparator);
    self _utils::LUI_close_menu(self.hud.thomasseparator);
    self _utils::LUI_close_menu(self.hud.thomasbar);
    self _utils::LUI_close_menu(self.hud.leftbar);
    self _utils::LUI_close_menu(self.hud.rightbar);
    self _utils::LUI_close_menu(self.hud.scrollbar);
}