import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const app = Main.embed(document.getElementById('root'));

registerServiceWorker();

app.ports.output.subscribe(console.log);

setTimeout(
		() => app.ports.incoming.send([ { score: 1, total: 2}] ),
		1000
	)
