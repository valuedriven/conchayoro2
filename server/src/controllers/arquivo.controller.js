const AWS = require('aws-sdk');

AWS.config.update({
   accessKeyId: process.env.AWS_ACCESS_KEY_ID,
   secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
   region: process.env.AWS_REGION
});

var s3 = new AWS.S3();

exports.listarArquivos = (req, res) => {
    async function listarArquivos(){        
        const data = s3.listObjects(
        {
            Bucket: process.env.BUCKET_NAME
        }
        ).promise();
        console.log(data);
        return data;
    };
    listarArquivos()
    .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Erros ocorreram ao recuperar objetos."
        });
      });
};


exports.get = (req, res) => {
    const id = req.params.id;
    console.log(id);
    async function getImage() {
        const data = s3.getObject(
            {
                Bucket: process.env.BUCKET_NAME,
                Key: process.env.FILE_KEY,
            }

        ).promise();        
        return data;
    }
    getImage()
    .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Erros ocorreram ao recuperar o arquivo."
        });
      });
};

exports.getArquivo = (req, res) => {
    const key = req.params.id;
    console.log(key);
    async function getImage() {
        const data = s3.getObject(
            {
                Bucket: process.env.BUCKET_NAME,
                Key: 'imagens'+key,
            }

        ).promise();
        var bucketParams = {
            Bucket: process.env.BUCKET_NAME,
          };
        s3.listObjects(bucketParams, function(err, data) {
            if (err) {
              console.log("Error", err);
            } else {
              console.log("Success", data);
            }
          });
        return data;
    }
    getImage()
    .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Erros ocorreram ao recuperar o arquivo."
        });
      });
};

exports.getOld = (req, res) => {
    async function getImage() {
        const data = s3.getObject(
            {
                Bucket: process.env.BUCKET_NAME,
                Key: 'imagens/wine1.jpg'
            }

        ).promise();
        var bucketParams = {
            Bucket: process.env.BUCKET_NAME,
          };
        s3.listObjects(bucketParams, function(err, data) {
            if (err) {
              console.log("Error", err);
            } else {
              console.log("Success", data);
            }
          });
        return data;
    }
    getImage()
        .then((img) => {
            let image = "<img src='data:image/jpeg;base64," + encode(img.Body) + "'" + "/>";
            let startHTML = "<html><body></body>";
            let endHTML = "</body></html>";
            let html = startHTML + image + endHTML;
            res.send(html)
        }).catch((e) => {
            res.send(e)
        })
    function encode(data) {
        let buf = Buffer.from(data);
        let base64 = buf.toString('base64');
        return base64
    }
};