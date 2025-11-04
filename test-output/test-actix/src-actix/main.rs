#[actix_web::main]
async fn main()->anyhow::Result<()>{
	test_actix_lib::run().await
}
