using Toybox.Communications;

class PhoneConnectionListener extends Communications.ConnectionListener{
	function initialize(){
		ConnectionListener.initialize();
	}

    function onComplete(){
        System.println("Message OK");
    }

    function onError(){
        System.println("Message ERROR");
    }


}