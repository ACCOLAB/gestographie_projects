 const btn = document.querySelector('button'),
            chunks = [];
          
          function record() {
            chunks.length = 0;
            let stream = document.querySelector('canvas').captureStream(30),
              recorder = new MediaRecorder(stream);
            recorder.ondataavailable = e => {
              if (e.data.size) {
                chunks.push(e.data);
              }
            };
            recorder.onstop = exportVideo;
            btn.onclick = e => {
              recorder.stop();
              btn.textContent = 'start recording';
              btn.onclick = record;
            };
            recorder.start();
            btn.textContent = 'stop recording';
          }
          
          function exportVideo(e) {
            var blob = new Blob(chunks);
            var vid = document.createElement('video');
            vid.id = 'recorded'
            vid.controls = true;
            vid.src = URL.createObjectURL(blob);
            document.body.appendChild(vid);
            vid.play();
          }
          btn.onclick = record;
          
          // taken from pr.js docs
          var x, y;
          
          var cap;
          function setup() {
            createCanvas(400, 400);
            cap = createCapture(VIDEO);
            cap.hide();
            imageMode(CENTER);
          }
          function draw() {
            background(50);
            image(cap, width/2, height/2, 160, 120);
          }