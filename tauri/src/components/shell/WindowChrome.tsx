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
                <p className={"mx-2 mt-1 text-lg font-bold select-none"} data-tauri-drag-region="">{{window_title}}</p>
            </div>
            <div className={"flex flex-row ml-auto"}>
                <ButtonGroup className={"h-[2rem]"} variant={"tertiary"}>
                    <ThemeSwitchComponent/>
                    <Button variant={"tertiary"} className={"min-w-0 h-[2rem] rounded-sm text-[1rem]"} onPress={() => appWindow.minimize()}><Icon icon="material-symbols:minimize-rounded"/></Button>
                    <Button variant={"tertiary"} className={"min-w-0 h-[2rem] rounded-sm text-[.7rem]"} onPress={() => appWindow.toggleMaximize()}><Icon icon="material-symbols:square-outline-rounded"/></Button>
                    <Button variant={"danger-soft"} className={"min-w-0 h-[2rem] rounded-sm text-[1rem]"} onPress={() => appWindow.close()}><Icon icon="material-symbols:close-rounded"/></Button>
                </ButtonGroup>
            </div>
        </div>
    );
}
{% else %}
import React from "react";
import {NavLink} from "react-router-dom";
import {ThemeSwitchComponent} from "../providers/ThemeProvider.tsx";

export default function Navigation()
{
    const [isMenuOpen, setIsMenuOpen] = React.useState(false);
    const pages = {
        "Home": "/"
    };

    const menuItems = (onNavigate?: () => void) =>
        Object.entries(pages).map(([item, url]) => (
            <li key={item}>
                <NavLink
                    to={url}
                    end
                    onClick={onNavigate}
                    className={({isActive}) => `link block w-full py-2 ${isActive ? "text-accent" : "text-foreground"}`}
                >
                    {item}
                </NavLink>
            </li>
        ));

    return (
        <nav className="sticky top-0 z-40 w-full border-b border-separator bg-background/70 backdrop-blur-lg">
            <header className="flex h-16 items-center justify-between px-6">
                <div className="flex items-center gap-4">
                    <button
                        className="sm:hidden"
                        onClick={() => setIsMenuOpen(prev => !prev)}
                        aria-label={isMenuOpen ? "Close menu" : "Open menu"}
                        aria-expanded={isMenuOpen}
                    >
                        <span className="sr-only">Menu</span>
                        <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            {isMenuOpen ? (
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12"/>
                            ) : (
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16"/>
                            )}
                        </svg>
                    </button>
                    <p className="font-bold text-inherit">{{window_title}}</p>
                </div>

                <ul className="hidden items-center gap-4 sm:flex">
                    {menuItems()}
                </ul>

                <div className="flex items-center gap-4">
                    <ThemeSwitchComponent/>
                </div>
            </header>

            {isMenuOpen && (
                <div className="border-t border-separator sm:hidden">
                    <ul className="flex flex-col gap-2 p-4">
                        {menuItems(() => setIsMenuOpen(false))}
                    </ul>
                </div>
            )}
        </nav>);
}
{% endif %}
