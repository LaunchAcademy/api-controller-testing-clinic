import React, { useState } from 'react'

import { BrowserRouter, Route, Switch } from 'react-router-dom'

import Campers from "./Campers"

export const App = (props) => {

  // const [currentUser, setCurrentUser] = useState({})

  return (

    <BrowserRouter>
      <Switch>
          <Route exact path="/campers" component={Campers} />
      </Switch>
    </BrowserRouter>
  )
}

export default App
