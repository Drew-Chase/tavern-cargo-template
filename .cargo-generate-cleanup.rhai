// Cleanup script to remove backend directories not needed for chosen backend
// Written in Rhai scripting language for cargo-generate

let backend = variable::get("backend");

file::delete("Cargo-actix.toml");
file::delete("Cargo-tauri.toml");

if backend == "actix" {
    // Keep: src-actix, remove others
    file::delete("src-tauri");
    file::delete("server");
    file::delete("app");
    file::delete("routes");
    file::delete("resources");
    file::delete("public");
    file::delete("bootstrap");
    file::delete("composer.json");
    file::delete(".env.example");
    file::rename("Cargo.toml", "Cargo-actix.toml.bak");
    file::rename("Cargo-actix.toml.bak", "Cargo.toml");
} else if backend == "tauri" {
    // Keep: src-tauri, remove others
    file::delete("src-actix");
    file::delete("server");
    file::delete("app");
    file::delete("routes");
    file::delete("resources");
    file::delete("public");
    file::delete("bootstrap");
    file::delete("composer.json");
    file::delete(".env.example");
    // Cargo.toml already has tauri content, keep it
} else if backend == "vanilla" {
    // Remove all backend directories
    file::delete("src-actix");
    file::delete("src-tauri");
    file::delete("server");
    file::delete("app");
    file::delete("routes");
    file::delete("resources");
    file::delete("public");
    file::delete("bootstrap");
    file::delete("Cargo.toml");
    file::delete("composer.json");
    file::delete(".env.example");
} else if backend == "nodejs" {
    // Keep: server, remove others
    file::delete("src-actix");
    file::delete("src-tauri");
    file::delete("app");
    file::delete("routes");
    file::delete("resources");
    file::delete("public");
    file::delete("bootstrap");
    file::delete("Cargo.toml");
    file::delete("composer.json");
    file::delete(".env.example");
} else if backend == "php" {
    // Keep: app, routes, resources, public, bootstrap, composer.json, .env.example
    // Remove: rust backends
    file::delete("src-actix");
    file::delete("src-tauri");
    file::delete("server");
    file::delete("Cargo.toml");
}
