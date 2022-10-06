#using scripts\shared\lui_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\util_shared;

#using scripts\mp\gametypes\components\_builtin;

#namespace _utils;

function LUI_create_text( text, alignment, x, y, rgb, alpha = 1 )
{    
    textElement = self OpenLUIMenu( "HudElementText" );
    self SetLuiMenuData( textElement, "alignment", alignment );
    self SetLuiMenuData( textElement, "x", x );
    self SetLuiMenuData( textElement, "y", y );
    self SetLuiMenuData( textElement, "text", text );

    if( alpha < 1 )
        self SetLuiMenuData( textElement, "alpha", alpha );

    lui::set_color(textElement, rgb);

    return textElement;
}

function LUI_create_rectangle( alignment, x, y, width, height, rgb, shader, alpha = 1 )
{
    boxElement = self OpenLUIMenu( "HudElementImage" );
    self SetLuiMenuData( boxElement, "alignment", alignment );
    self SetLuiMenuData( boxElement, "x", x );
    self SetLuiMenuData( boxElement, "y", y );
    self SetLuiMenuData( boxElement, "width", width );
    self SetLuiMenuData( boxElement, "height", height );
    self SetLuiMenuData( boxElement, "material", shader );

    if( alpha < 1 )
        self SetLuiMenuData( boxElement, "alpha", alpha );

    lui::set_color(boxElement, rgb);

    return boxElement;
}

function LUI_close_menu(lui)
{
    self closeluimenu(lui);
}

function create_menu(menu, title, parent)
{
    self.menu.title[menu] = title;
    self.menu.parent[menu] = parent;
}

function add_option(menu, index, text, func, input)
{
    self.menu.text[menu][index] = text;
    self.menu.func[menu][index] = func;
    self.menu.input[menu][index] = input;
}