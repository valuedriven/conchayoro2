const AWS = require('aws-sdk');

AWS.config.update({
   accessKeyId: 'AKIAUCAQL4TJ4EKEF7UR',
   secretAccessKey: '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',
   region: 'sa-east-1'
});

s3 = new AWS.S3({apiVersion: '2006-03-01'});

// console.log('listar buckets');
// s3.listBuckets(function(err, data) {
//   if (err) {
//     console.log("Error", err);
//   } else {
//     console.log("Success", data.Buckets);
//   }  
// });

var bucketParams = {
  Bucket : 'conchayoro-jps'
  // Delimiter: '/'
};

console.log('listar objetos');
s3.listObjects(bucketParams, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    console.log("Success", data.Contents);
  }
});

