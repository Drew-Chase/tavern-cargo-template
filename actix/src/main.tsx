import React from "react";
import {BrowserRouter, Route, Routes} from "react-router-dom";
import ReactDOM from "react-dom/client";

import "./assets/css/index.css";
import Home from "./assets/pages/Home.tsx";
import About from "./assets/pages/About.tsx";
import Navigation from "./assets/components/Navigation.tsx";
import {ThemeProvider} from "./assets/providers/ThemeProvider.tsx";


ReactDOM.createRoot(document.getElementById("root")!).render(
    <React.StrictMode>
        <BrowserRouter>
            <ThemeProvider>
                <MainContentRenderer/>
            </ThemeProvider>
        </BrowserRouter>
    </React.StrictMode>
);

export function MainContentRenderer()
{
    return (
        <>
            <Navigation/>
            <Routes>
                <Route>
                    <Route path="/" element={<Home/>}/>
                    <Route path="/about" element={<About/>}/>
                </Route>
            </Routes>
        </>
    );
}
