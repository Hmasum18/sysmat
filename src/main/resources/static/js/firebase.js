
function onImageSelected(inputImageField, previewImg, imageUrlHolderHiddenInputField){
    const funcName = "onImageSelected(): ";
    console.log(funcName);
    inputImageField.addEventListener("change", function() {
        console.log(funcName+"image selected for logo")
        if (this.files && this.files[0]) {
            uploadToFirebase(this.files[0],function (imageUrl){
                console.log(funcName+"adding image url to src")
                imageUrlHolderHiddenInputField.setAttribute("value", imageUrl);
                previewImg.setAttribute('src', imageUrl);
            });
        }
    });
}

function uploadToFirebase(file ,onUploadSuccess){
    const fileName = file.name;

    // Points to the root reference
    const storageRef = firebase.storage().ref();

    // Points to 'images'
    const imagesStorageRef = storageRef.child('images');

    // space ref where image will be stored
    const currentDate = new Date().getTime();
    const spaceRef = imagesStorageRef.child(currentDate+"-"+fileName);

    const uploadTask = spaceRef.put(file);
    /* .then(function (snapshot) {
         console.info("image uploaded in firebase");
         // Handle successful uploads on complete
         // For instance, get the download URL: https://firebasestorage.googleapis.com/...
             uploadTask.snapshot.ref.getDownloadURL().then((downloadURL) => {
             console.log('File available at', downloadURL);

             const logUrlInputField = document.querySelector("#logoUrl")
             logUrlInputField.setAttribute("value", downloadURL);

             onUploadSuccess(downloadURL);
     })*/


    uploadTask.on('state_changed',
        (snapshot) => {
            // Observe state change events such as progress, pause, and resume
            // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
            let progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
            const imageUploadProgressBar = document.querySelector("#imageUploadProgressBar");
            imageUploadProgressBar.setAttribute("style","width: "+progress+"%;");
            imageUploadProgressBar.setAttribute("aria-valuenow", progress+"");
        },
        (error) => {
            // Handle unsuccessful uploads
        },
        () => {
            uploadTask.snapshot.ref.getDownloadURL().then((downloadURL) => {
                console.log('File available at', downloadURL);
                onUploadSuccess(downloadURL);
            });
        }
    );
}