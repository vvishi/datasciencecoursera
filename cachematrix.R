## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
      InvMtrx <- NULL
      
      set <- function(y){
        x <<- y
        InvMtrx <<- NULL
      }
      
      get <- function() x
      
      setMtrx <- function(Mtrx) InvMtrx <<- Mtrx
      
      getMtrx <- function() InvMtrx
      
      list(set = set, get = get, setMtrx = setMtrx, getMtrx = getMtrx)
}


## Write a short comment describing this function
## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should 
## retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
        InvMtrx <- x$getMtrx()
        
        if(!is.null(InvMtrx)) {
                message("getting cached Matrix")
                return(InvMtrx)
        }
        
        data <- x$get()
        
        InvMtrx <- solve(data)  ### this piece of code refered one
        
        x$setmean(InvMtrx)
        
        InvMtrx
}
