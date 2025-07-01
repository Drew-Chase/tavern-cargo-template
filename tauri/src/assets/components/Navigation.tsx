{% if custom_chrome == true %}
import {Button, ButtonGroup} from "@heroui/react";
import {ThemeSwitchComponent} from "../providers/ThemeProvider.tsx";
import {getCurrentWindow} from "@tauri-apps/api/window";
import {Icon} from "@iconify-icon/react";

export default function Navigation()
{
    const appWindow = getCurrentWindow();
    return (

        <div className={"flex flex-row h-[2.5rem] backdrop-blur-sm sticky top-0 w-full z-[51] backdrop-saturate-150 select-none"} data-tauri-drag-region="">
            <div className={"flex flex-row"}>
                <p className={"mx-2 mt-1 text-large font-bold select-none"} data-tauri-drag-region="">Sams Manifest Compiler</p>
            </div>
            <div className={"flex flex-row ml-auto"}>
                <ButtonGroup className={"h-[2rem]"}>
                    <ThemeSwitchComponent/>
                    <Button variant={"light"} className={"min-w-0 h-[2rem] text-[1rem]"} radius={"sm"} onPress={() => appWindow.minimize()}><Icon icon="material-symbols:minimize-rounded"/></Button>
                    <Button variant={"light"} color={"danger"} className={"min-w-0 h-[2rem] text-[1rem]"} radius={"sm"} onPress={() => appWindow.close()}><Icon icon="material-symbols:close-rounded"/></Button>
                </ButtonGroup>
            </div>
        </div>
    );
}
{% else %}
import React from "react";
import {Link, Navbar, NavbarBrand, NavbarContent, NavbarItem, NavbarMenu, NavbarMenuItem, NavbarMenuToggle} from "@heroui/react";
import {ThemeSwitchComponent} from "../providers/ThemeProvider.tsx";

export default function Navigation()
{

    const [isMenuOpen, setIsMenuOpen] = React.useState(false);
    const pages = {
        "Home": "/",
        "About": "/about"
    };
    const menuItems = Object.keys(pages).map((item, index) =>
    {
        const url = Object.values(pages)[index];
        const isCurrentPage = window.location.pathname === url;
        return (
            <NavbarMenuItem key={`${item}-${index}`}>
                <Link href={url} color={isCurrentPage ? "primary" : "foreground"} aria-current="page" size="lg" className="w-full">
                    {item}
                </Link>
            </NavbarMenuItem>
        );
    });


    return (
        <Navbar onMenuOpenChange={setIsMenuOpen}>
            <NavbarContent>
                <NavbarMenuToggle aria-label={isMenuOpen ? "Close menu" : "Open menu"} className="sm:hidden"/>
                <NavbarBrand>
                    <p className="font-bold text-inherit">tauri</p>
                </NavbarBrand>
            </NavbarContent>

            <NavbarContent className="hidden sm:flex gap-4" justify="center">
                {menuItems}
            </NavbarContent>
            <NavbarContent justify="end">
                <NavbarItem>
                    <ThemeSwitchComponent/>
                </NavbarItem>
            </NavbarContent>

            <NavbarMenu>
                {menuItems}
            </NavbarMenu>
        </Navbar>);
}
{% endif %}
