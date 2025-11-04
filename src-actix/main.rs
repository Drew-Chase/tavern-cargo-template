#[actix_web::main]
async fn main()->anyhow::Result<()>{
	{{crate_name}}_lib::run().await
}
