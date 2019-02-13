import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {

	public static void main(String[] args) throws IOException, InterruptedException {
		String urlSegura = "https://www.example.com.br";
		urlSegura = urlSegura.replace("https://", "").replace("www.", "");
		Process procBuildScript = new ProcessBuilder("/root/bin/virtual-host-certbot-apache/script-config-host.sh", urlSegura,"1").start();
		procBuildScript.waitFor();
		
		BufferedReader inputStream = new BufferedReader(new InputStreamReader(procBuildScript.getInputStream()));
		BufferedReader errorStream = new BufferedReader(new InputStreamReader(procBuildScript.getErrorStream()));
		
		String s;
		
		while((s = inputStream.readLine()) != null) {
			if(s.contains("Invalid response from")) {
				System.err.println("Erro: Não foi possível acessar o domínio. Verifique permissões");
			}
			if(s.contains("Congratulations")) {
				System.err.println("Alerta: Sucesso na criação do host e certificado!");
			}
			
		}
		while((s = errorStream.readLine()) != null) {
			if(s.contains("ln: failed to create symbolic link")) {
				System.err.println("Alerta: Falha ao criar link simbólico");
			}
			if(s.contains("Failed authorization procedure")) {
				System.err.println("Erro: Falha ao criar certificado");
			}
			if(s.contains("Congratulations")) {
				System.err.println("Alerta: Sucesso na criação do host e certificado!");
			}
		}
		procBuildScript.destroy();
	}

}

