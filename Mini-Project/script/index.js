function redirectToUploadPage() {
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;

  if (email && password) {
    // Redirect to the upload page
    window.location.href = 'upl.html';
    return false; // Prevent default form submission
  } else {
    alert('Please fill in both email and password!');
    return false; // Prevent redirection if fields are empty
  }
}