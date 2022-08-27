import app from "./src/app.js"

const _port = 4000;

app.listen(_port, () => {
   console.log(`Server listening at ${_port}`);
});

export default app;