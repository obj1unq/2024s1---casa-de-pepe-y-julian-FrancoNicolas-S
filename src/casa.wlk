object casa2{
	var property viveres = 50
	var property montoReparaciones = 0
	var cuentaBancaria = cuentaCorriente
	var estrategiaAhorro = full
	
	


	method estrategiaAhorro(_estrategiaAhorro){
		estrategiaAhorro = _estrategiaAhorro
	}
	
	method cuentaBancaria(_cuentaBancaria){
		cuentaBancaria = _cuentaBancaria
	}
	
	method saldo(){
		return self.saldoEnCuenta() - self.gastos() 
	}
	
	method saldoEnCuenta(){
		return	cuentaBancaria.saldo()
	}
	
	method gastos(){
		return estrategiaAhorro.gastosEstrategia(self)
	}
	
	
	method extraerGastosCuenta(){
		cuentaBancaria.extraer(self.gastos())	
		}
		
	method depositarEnCuenta(monto){
		cuentaBancaria.depositar(monto)
	}	
		
		
	method cantidadViveres(){
		return viveres + estrategiaAhorro.compraViveres(self) / estrategiaAhorro.calidad()
	}
		
	
	method tieneViveresSuficientes(){
		return viveres >= 40
	}
	
	method hayQueHacerReparaciones(){
		return montoReparaciones > 0
	}
	
	
	method casaEnOrden(){
		return not self.hayQueHacerReparaciones() && self.tieneViveresSuficientes()
	}
}








object casaDePepeYJulian {
	var property viveres = 50
	var property montoReparaciones = 0
	var cuentaBancaria = cuentaCorriente
	var estrategiaAhorro = full
	
	


	method estrategiaAhorro(_estrategiaAhorro){
		estrategiaAhorro = _estrategiaAhorro
	}
	
	method cuentaBancaria(_cuentaBancaria){
		cuentaBancaria = _cuentaBancaria
	}
	
	method saldo(){
		return self.saldoEnCuenta() - self.gastos() 
	}
	
	method saldoEnCuenta(){
		return	cuentaBancaria.saldo()
	}
	
	method gastos(){
		return estrategiaAhorro.gastosEstrategia(self)
	}
	
	
	method extraerGastosCuentaBancaria(){
		cuentaBancaria.extraer(self.gastos())	
		}
		
		
	method cantidadViveres(){
		return viveres + estrategiaAhorro.compraViveres(self) / estrategiaAhorro.calidad()
	}
		
	
	method tieneViveresSuficientes(){
		return viveres >= 40
	}
	
	method hayQueHacerReparaciones(){
		return montoReparaciones > 0
	}
	
	
	method casaEnOrden(){
		return not self.hayQueHacerReparaciones() && self.tieneViveresSuficientes()
	}
	
}

//Estrategias de ahorro

object minimoEIndispensasble{
	var calidad = 2
	
	method calidad(_calidad){
		calidad = _calidad
	}
	
	method calidad(){
		return calidad
	}
		
	method viveresFaltantes(casa){
		if (casa.viveres() < 40){
				return  40 - casa.viveres()
			}else{
				return 0
			}
	}	
		
	method compraViveres(casa){
		
		return self.viveresFaltantes(casa) * calidad
		
	}
	
	method gastosEstrategia(casa){
			return self.compraViveres(casa) 
	}
		
	
}


object full{
	const calidad = 5
	
	method calidad(){
		return calidad
	}
	
	method viveresFaltantes(casa){
		return 100 - casa.viveres()
	}
	
	method compraViveres(casa){
		if (casa.casaEnOrden()){
			return self.viveresFaltantes(casa) * calidad
		}else if(casa.viveres() < 61){
				return 40 * calidad
			}else{
				return self.viveresFaltantes(casa) * calidad
			}
	}
	
	
	method cubrirReparaciones(casa){
		if (casa.saldoEnCuenta() - casa.montoReparaciones() > 1000){
		return casa.montoReparaciones()
	 	}else{
			return 0
		}
	}	
	
	method gastosEstrategia(casa){
			return self.compraViveres(casa) + self.cubrirReparaciones(casa)
	}
	
}
//Cuentas Bancarias

object cuentaCorriente{
	var saldo = 0
	
	method depositar(deposito){
		saldo = saldo + deposito
	}
	
	method extraer(extraccion){
		saldo = saldo - extraccion
	}
	
	method saldo(){
		return saldo
	}
}

object cuentaConGastos{
	var saldo = 0
	var costoDeOperacion = 0
	
	method costoDeOperacion(_costoDeOperacion){
		costoDeOperacion = _costoDeOperacion
	}
	
	method depositar(deposito){
		saldo = saldo + deposito - costoDeOperacion
	}
	
	method extraer(extraccion){
		saldo = saldo - extraccion
	}
	
	method saldo(){
		return saldo
	}
}

object cuentaCombinada{
	
	var property cuentaPrimaria = cuentaCorriente
	var property cuentaSecundaria = cuentaConGastos
	
	method saldo(){
		return self.saldoCuentaPrimaria() + self.saldoCuentaSecundaria()
	}
	
	method saldoCuentaPrimaria(){
		return cuentaPrimaria.saldo()
	}
	
	method saldoCuentaSecundaria(){
		return cuentaSecundaria.saldo()
	}
	
	method depositar(deposito){
		cuentaPrimaria.depositar(deposito)
	}
	
	method extraer(extraccion){
		if (cuentaPrimaria.saldo() >= extraccion) {
			cuentaPrimaria.extraer(extraccion)			
		}else{
			cuentaSecundaria.extraer(extraccion)
		}
	}
	
}
